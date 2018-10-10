#!/bin/sh

TABLE_SCHEMA='cloud_sql_2_bq'
mysql_connect="mysql --host=104.196.177.8 --user=root --password=changeME"

cat > all_tables_query.txt << heredoc
SELECT TABLE_NAME FROM information_schema.columns WHERE table_schema = '$TABLE_SCHEMA' GROUP BY 1
heredoc

table_name=`$mysql_connect -Bs < all_tables_query.txt`

for i in $table_name
do
sh ./mysql_to_big_query.sh $TABLE_SCHEMA $i > script_succ.txt 2> script_err.txt
done
