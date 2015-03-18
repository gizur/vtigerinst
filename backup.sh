#!/bin/bash
source /env
FILE=$db_name-`hostname`-`date +%Y%m%d`.sql
mysqldump -h$db_server -u$db_username -p$db_password --port=3306 --single-transaction --routines --triggers --databases $db_name --compress --compact > /$FILE
gzip -f /$FILE
/usr/bin/python /usr/local/bin/s3cmd -c /.s3cfg put /$FILE.gz s3://gc1-backups/
rm /$FILE.gz
