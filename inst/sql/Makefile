plat = ~/production.duckdb


reload_dataImports:
	@echo "reloaded dataImports schema"
	@duckdb $(plat) < teardown_dataImports.sql
	@duckdb $(plat) < setup_dataImports.sql
	@Rscript --default-package=dsa -e 'dsa::main_write()'
	@duckdb $(plat) < insert_dataImports.sql

reload_main:
	@echo "reloaded main schema"
	@duckdb $(plat) < teardown_main.sql
	@duckdb $(plat) < setup_main.sql
	@duckdb $(plat) < insert_main.sql



