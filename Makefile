plat = 'md:prod_lat'

reload_dataImports:
	@echo "reloaded dataImports schema"
	duckdb $(plat) < inst/sql/teardown/teardown_dataImports.sql
	duckdb $(plat) < inst/sql/ddl_lat/setup_dataImports.sql
	Rscript --default-packages=dsa -e 'dsa::main_write()'
	duckdb $(plat) < inst/sql/inserts/insert_dataImports.sql

reload_main:
	@echo "reloaded main schema"
	duckdb $(plat) < inst/sql/teardown/teardown_main.sql
	duckdb $(plat) < inst/sql/ddl_lat/setup_main.sql
	duckdb $(plat) < inst/sql/inserts/insert_main.sql

ingest_R:
	@echo "ingested new data into database"
	Rscript --default-packages=dsa -e 'dsa::main_write()'
	duckdb $(plat) < inst/sql/inserts/insert_dataImports.sql
	duckdb $(plat) < inst/sql/inserts/insert_main.sql
	duckdb $(plat) < inst/sql/analysis/olap.sql

ingest_excel:
	@echo "ingested new data into database from stagging table into normalized table"
	duckdb $(plat) < inst/sql/inserts/insert_excel.sql
	duckdb $(plat) < inst/sql/inserts/insert_data.sql
	duckdb $(plat) < inst/sql/inserts/insert_main.sql
	duckdb $(plat) < inst/sql/analysis/olap.sql

sum: 
	duckdb $(plat) < inst/sql/olap.sql

setup:
	@echo "setup database"
	duckdb $(plat) < inst/sql/ddl_lat/etup_dataImports.sql
	duckdb $(plat) < inst/sql/ddl_lat/setup_main.sql

teardown:
	duckdb $(plat) < inst/sql/teardown_dataImports.sql
	duckdb $(plat) < inst/sql/teardown_main.sql

