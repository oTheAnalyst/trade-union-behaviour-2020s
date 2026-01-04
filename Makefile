plat = 'md:prod_lat'

reload_dataImports:
	@echo "reloaded dataImports schema"
	duckdb $(plat) < inst/sql/teardown_dataImports.sql
	duckdb $(plat) < inst/sql/setup_dataImports.sql
	Rscript --default-packages=dsa -e 'dsa::main_write()'
	duckdb $(plat) < inst/sql/insert_dataImports.sql

reload_main:
	@echo "reloaded main schema"
	duckdb $(plat) < inst/sql/teardown_main.sql
	duckdb $(plat) < inst/sql/setup_main.sql
	duckdb $(plat) < inst/sql/insert_main.sql

ingest_R:
	@echo "ingested new data into database"
	Rscript --default-packages=dsa -e 'dsa::main_write()'
	duckdb $(plat) < inst/sql/insert_dataImports.sql
	duckdb $(plat) < inst/sql/insert_main.sql
	duckdb $(plat) < inst/sql/olap.sql

ingest_excel:
	@echo "ingested new data into database from stagging table into normalized table"
	duckdb $(Plat) < inst/sql/insert_excel.sql
	duckdb $(Plat) < inst/sql/insert_data.sql
	duckdb $(plat) < inst/sql/insert_main.sql
	duckdb $(plat) < inst/sql/olap.sql

sum: 
	duckdb $(plat) < inst/sql/olap.sql

setup:
	@echo "setup database"
	duckdb $(plat) < inst/sql/setup_dataImports.sql
	duckdb $(plat) < inst/sql/setup_main.sql

teardown:
	duckdb $(plat) < inst/sql/teardown_dataImports.sql
	duckdb $(plat) < inst/sql/teardown_main.sql

