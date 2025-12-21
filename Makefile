plat = 'md:prod_lat'

reload_dataImports:
	@echo "reloaded dataImports schema"
	duckdb $(plat) < teardown_dataImports.sql
	duckdb $(plat) < setup_dataImports.sql
	Rscript --default-packages=dsa -e 'dsa::main_write()'
	duckdb $(plat) < insert_dataImports.sql

reload_main:
	@echo "reloaded main schema"
	duckdb $(plat) < teardown_main.sql
	duckdb $(plat) < setup_main.sql
	duckdb $(plat) < insert_main.sql

ingest_data:
	@echo "ingested new data into database"
	Rscript --default-packages=dsa -e 'dsa::main_write()'
	duckdb $(plat) < insert_dataImports.sql
	duckdb $(plat) < insert_main.sql
	duckdb $(plat) < olap.sql

sum: 
	duckdb $(plat) < olap.sql

setup:
	@echo "setup database"
	duckdb $(plat) < setup_dataImports.sql
	duckdb $(plat) < setup_main.sql

teardown:
	duckdb $(plat) < teardown_dataImports.sql
	duckdb $(plat) < teardown_main.sql

