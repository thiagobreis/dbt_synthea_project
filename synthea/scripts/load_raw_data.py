import duckdb

con = duckdb.connect('./dev.duckdb')
con.execute("CREATE SCHEMA IF NOT EXSISTS raw")

tables = [
    'allergies','careplans','claims','claims_transactions','conditions','devices'
    'encounters','imaging_studies','immnunizations','medications','observations','organizations'
    'patients','payers_transictions','payers','procedures','providers','supplies'
]

for t in tables:
    con.execute(f"""
       CREATE OR REPLACE TABLE raw.{t} AS
       SELECT * FROM read_csv_auto('./csv/{t}.csv'), header = True        
    """)
    
con.close()