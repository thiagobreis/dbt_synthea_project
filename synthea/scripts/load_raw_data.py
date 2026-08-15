import duckdb
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
REPO_ROOT = PROJECT_ROOT.parent

DB_PATH = PROJECT_ROOT / "dev.duckdb"
CSV_DIR = REPO_ROOT / "csv"

con = duckdb.connect(str(DB_PATH))
con.execute("CREATE SCHEMA IF NOT EXISTS raw")


tables = [
    'allergies','careplans','claims','claims_transactions','conditions','devices',
    'encounters','imaging_studies','immunizations','medications','observations','organizations',
    'patients','payer_transitions','payers','procedures','providers','supplies'
]

for t in tables:
    print(f"CREATING TABLE {t}")
    con.execute(f"""
       CREATE OR REPLACE TABLE raw.{t} AS
       SELECT * FROM read_csv_auto('../csv/{t}.csv', header = True)
    """)
    
con.close()