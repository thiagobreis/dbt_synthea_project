import duckdb
from pathlib import Path
import logging
import os
from dotenv import load_dotenv
import traceback 

ENV_PATH = Path(__file__).resolve().parent.parent / ".env"
load_dotenv(ENV_PATH)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
    )


DB_PATH = Path(os.environ["DUCKDB_PATH"])
CSV_DIR = Path(os.environ["CSV_DIR"])
RAW_SCHEMA = os.environ["RAW_SCHEMA"]
RAW_TABLES = os.environ["RAW_TABLES"].split(",")

con = duckdb.connect(str(DB_PATH))
con.execute("CREATE SCHEMA IF NOT EXISTS raw")


tables = RAW_TABLES

success = []
fail = []
errors = []

for t in tables:
    try: 
        with open(f'{CSV_DIR}/{t}.csv',encoding='utf-8') as file:  
            logging.info(f"CREATING TABLE {t}")
            con.execute(f"""
            CREATE OR REPLACE TABLE {RAW_SCHEMA}.{t} AS
            SELECT * FROM read_csv_auto('{CSV_DIR}/{t}.csv', header = True)
            """)
            success.append(t)
    except FileNotFoundError:
        logging.error(f">>>> File '{t}.csv' not found.")
        fail.append(t)
        errors.append(f"{t}: File '{t}.csv' not found")
    except Exception as e:
        logging.error(f">>>> Unexpected error loading '{t}: {e}")
        fail.append(t)
        errors.append(f"{t}: {e}\n{traceback.format_exc()}")

        
con.close()

print('----------')
if len(fail) == 0:
    logging.info(f"All tables succesfully created")
else:
    logging.warning(f""">>>> {len(fail)} tables with error.
                    >>>> Error creating tables: {fail}.
                    Check log file for detailed information.""")
    with open('errors_load.log','w', encoding='utf-8') as file:
        file.write("\n".join(errors))

