vlrst
vlrst
clear
ls
clear
tree
dbeaver inst/sql/init.sql 
clear
tree
cd inst/sql/
clear
ls
duckdb -init init.sql > test.duckdb
clear
ls
clear
ls -la
cd inst/sql/
clear
ls -la
duckdb teardown_main.sql >> ~/production.duckdb
duckdb --help
clear && ls -la
duckdb < teardown_main.sql 
duckdb < setup_main.sql 
duckdb < setup_main.sql 
duckdb < teardown_main.sql 
duckdb < setup_main.sql 
duckdb < setup_main.sql 
duckdb ~/production.duckdb < setup_main.sql 
duckdb ~/production.duckdb < teardown_main.sql 
duckdb ~/production.duckdb < teardown_main.sql 
duckdb ~/production.duckdb < teardown_main.sql 
duckdb ~/production.duckdb < setup_main.sql 
duckdb ~/production.duckdb << setup_main.sql 


duckdb ~/production.duckdb < setup_main.sql 
exit
