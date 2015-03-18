#!/bin/bash
#

# get the rds db instanceID from command line (or crontab) entry
#
AWS_INSTANCE=$1

# here's where we'll store the latest slowquery.log
#
SLOWLOG=/rds_slow.log
#SLOWLOG=`/bin/ls -tr /home/shull/*.log | /usr/bin/tail -1`

# fetch slow query log from rds box
# here I always grab the latest one.
#
/usr/local/bin/aws rds download-db-log-file-portion --db-instance-identifier $AWS_INSTANCE --output text --log-file-name slowquery/mysql-slowquery.log > $SLOWLOG

# query report output
SLOWREPORT=/report_slow.txt

# pt-query-digest location
MKQD=/usr/bin/pt-query-digest

# run the tool to get analysis report
$MKQD $SLOWLOG > $SLOWREPORT

# today's date in a variable
TODAY=`/bin/date +\%m/\%d/\%Y-\%H:\%S`
#YESTERDAY=`/bin/date -d "1 day ago" +\%m/\%d/\%Y-\%H:\%S`

# report subject
#SUBJECT="Sean Query Report -- $TODAY "

# recipient
#EMAIL="hullsean@gmail.com"

# send an email using /bin/mail
#/usr/bin/mailx -s "$SUBJECT" "$EMAIL" < $SLOWREPORT

cat $SLOWREPORT
