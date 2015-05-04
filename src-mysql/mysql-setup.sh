#!/bin/sh

/usr/sbin/mysqld &
sleep 5
echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
echo "GRANT ALL ON *.* TO admin@'localhost' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql


#
# Create empty vTiger DB
#

DBNAME="vtiger"
DBUSER="vtiger"
DBPASSWORD="vtiger"

echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | mysql
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | mysql


#
# Create vTiger Demo DB
#

DBNAME="vtigerdemo"
DBUSER="vtigerdemo"
DBPASSWORD="vtigerdemo"
SQLFILE="/src-mysql/vtiger.sql"

echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | mysql
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | mysql
gunzip $SQLFILE
mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE


#
# Create vTiger Cikab DB
#

DBNAME="vtiger_5159ff6a"
DBUSER="vtiger_5159ff6a"
DBPASSWORD="vtiger_5159ff6a"
SQLFILE="/src-mysql/vtiger_5159ff6a-vtiger2-20150318.sql"

echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | mysql
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | mysql
gunzip $SQLFILE
mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE


#
# Create vTiger Clab DB
#

DBNAME="clabgizurcom"
DBUSER="clabgizurcom"
DBPASSWORD="clabgizurcom"
SQLFILE="/src-mysql/clab-vtiger-20150419.sql"

echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | mysql
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | mysql
gunzip $SQLFILE
mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE
