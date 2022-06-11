#!bin/bash

mysql -uroot -pmysql test < "/docker-entrypoint-initdb.d/sql/schema.sql"
mysql -uroot -pmysql test < "/docker-entrypoint-initdb.d/sql/data.sql"
