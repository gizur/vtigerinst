#!/bin/sh

CMD='mysql -uroot -pmysql-server'

echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | $($CMD)
echo "GRANT ALL ON *.* TO admin@'localhost' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | $($CMD)


#
# Create empty vTiger DB
#

DBNAME="vtiger"
DBUSER="vtiger"
DBPASSWORD="vtiger"

echo "drop user $DBUSER@'localhost'; drop user $DBUSER@'%'; drop database $DBNAME"|$($CMD)
echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | $($CMD)
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | $($CMD)


#
# Create vTiger Demo DB
#

DBNAME="vtigerdemo"
DBUSER="vtigerdemo"
DBPASSWORD="vtigerdemo"
SQLFILE="./vtiger.sql"

echo "drop user $DBUSER@'localhost'; drop user $DBUSER@'%'; drop database $DBNAME"|$($CMD)
echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | $($CMD)
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | $($CMD)
gunzip $SQLFILE
mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE


#
# Create vTiger Cikab DB
#

#DBNAME="vtiger_5159ff6a"
#DBUSER="vtiger_5159ff6a"
#DBPASSWORD="vtiger_5159ff6a"
#SQLFILE="./vtiger_5159ff6a-vtiger2-20150318.sql"

#echo "drop user $DBUSER@'localhost'; drop user $DBUSER@'%'; drop database $DBNAME"|$($CMD)
#echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | $($CMD)
#echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
#echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
#echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | $($CMD)
#gunzip $SQLFILE
#mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE


#
# Create vTiger Clab DB
#

DBNAME="clabgizurcom"
DBUSER="clabgizurcom"
DBPASSWORD="clabgizurcom"
SQLFILE="./clab-vtiger-20150419.sql"

echo "drop user $DBUSER@'localhost'; drop user $DBUSER@'%'; drop database $DBNAME"|$($CMD)
echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | $($CMD)
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | $($CMD)
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | $($CMD)
gunzip $SQLFILE
mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE
