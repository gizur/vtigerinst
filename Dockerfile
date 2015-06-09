# MySQL Server with Apache and phpmyadmin
#
# VERSION               0.0.1
#
# Docs:
# - http://cweiske.de/tagebuch/Running%20Apache%20with%20a%20dozen%20PHP%20versions.htm
# - http://cweiske.de/tagebuch/Introducing%20phpfarm.htm
#
# It's a good idea to place thigs that change often at the end. The build takes less time
# this way since more of the build cache can be used.
#
# Guidelines
# ----------
#
# * Always use ubuntu:latest. Problems with new ubuntu releases should be fixed before
#  moving new images into production.
#  - ubuntu 14.10 has this problem: /usr/bin/ld: ext/openssl/openssl.o: undefined reference to symbol 'SSL_get_verify_result@@OPENSSL_1.0.0'
#
# * Daemons are managed with supervisord.
#
# * Logging from all daemons should be performed to `/var/log/supervisor/supervisord.log`.
#   The start script will `tail -f` this log so it shows up in `docker logs`. The log file of
#   daemons that can't log to `/var/log/supervisor/supervisord.log` should also be tailed
#   in `start.sh`

FROM     centos:6
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

RUN echo "export HOME=/root" >> /root/.profile

RUN yum install -y wget nano curl git unzip which


#
# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. yum don't always work.

RUN yum install -y python python-setuptools
RUN easy_install supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Install rsyslog
# ---------------

RUN yum install -y rsyslog

ADD ./etc-rsyslog.conf /etc/rsyslog.conf


#
# Install Apache
# ---------------

RUN yum install -y httpd php
#RUN a2enmod rewrite status
ADD ./etc-apache2-apache2.conf /etc/apache2/apache2.conf
ADD ./etc-apache2-mods-available-status.conf /etc/apache2/mods-available/status.conf

#RUN rm /var/www/html/index.html
RUN echo "<?php\nphpinfo();\n " > /var/www/html/info.php


#
# Install MySQL
# -------------

# Install scripts
ADD ./src-mysql /src-mysql

# Add source code for SQL-scripts and vTiger instances
#ADD ./src-instances /src-instances

# Install MySQL server
#RUN DEBIAN_FRONTEND=noninteractive yum install -y mysql-server

# Fix configuration
#RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user and load data
#RUN /src-mysql/mysql-setup.sh


#
# Install phpMyAdmin
# ----------------------------------
#

# Install phpMyAdmin
ADD ./src-phpmyadmin/phpMyAdmin-4.0.8-all-languages.tar.gz /var/www/html/
ADD ./src-phpmyadmin/config.inc.php /var/www/html/phpMyAdmin-4.0.8-all-languages/config.inc.php

# New version
ADD ./src-phpmyadmin/phpMyAdmin-4.3.12-all-languages.tar.gz /var/www/html/
ADD ./src-phpmyadmin/config.inc.php /var/www/html/phpMyAdmin-4.3.12-all-languages/config.inc.php


# Either use pre-configured vTiger, or standard installation package
# --------------------------------------------------------------------

# Install vTiger, use the files produced from the installation script
ADD ./vtigercrm-installed.tgz /var/www/html/

# Customized to fetch db credentials from environment variables
ADD ./src-vtiger/config.inc.php /var/www/html/vtigercrm/
ADD ./src-vtiger/config.performance.php /var/www/html/vtigercrm/
ADD ./src-vtiger/log4php.properties /var/www/html/vtigercrm/


# --------------------------------------------------------------------

# Install vTiger, the installation script will run the first time
# Use the vtiger/vtiger/vtiger credentials (empty db)
#ADD ./vtigercrm-5.4.0.tar.gz /var/www/html/

# --------------------------------------------------------------------


# Cikab customizations
ADD ./src-vtiger/cikab/CikabTroubleTicket /var/www/html/vtigercrm/modules/CikabTroubleTicket
ADD ./src-vtiger/cikab/soap/customerportal.php /var/www/html/vtigercrm/soap/customerportal.php
ADD ./src-vtiger/include-Webservice-LoginCustomer.php /var/www/html/vtigercrm/include/Webservices/LoginCustomer.php


#
# Install Percona Toolkit (for MySQL performance tuning of local MySQL)
# --------------------------------------------------------------------

#RUN gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
#RUN gpg -a --export CD2EFD2A | apt-key add -
#RUN echo "deb http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list
#RUN echo "deb-src http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list
#RUN yum update
#RUN yum install -y percona-toolkit


#
# Install RDS Command Line Tools (for MySQL performance tuning of RDS MySQL)
# --------------------------------------------------------------------------
# http://docs.aws.amazon.com/AmazonRDS/latest/CommandLineReference/StartCLI.html

#RUN yum install -y openjdk-6-jdk unzip
#RUN echo "export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64" >> /root/.profile
#RUN wget http://s3.amazonaws.com/rds-downloads/RDSCli.zip
#RUN unzip RDSCli.zip
#RUN echo "export AWS_RDS_HOME=/RDSCli-1.19.004" >> /root/.profile
#RUN echo "export PATH=$PATH:$AWS_RDS_HOME/bin" >> /root/.profile
#RUN echo "export EC2_REGION=eu-west-1" >> /root/.profile
#RUN echo "AWSAccessKeyId=<Write your AWS access ID>" > /RDSCli-1.19.004/credentials
#RUN echo "AWSSecretKey=<Write your AWS secret key>" >> /RDSCli-1.19.004/credentials
#RUN echo "export AWS_CREDENTIAL_FILE=/RDSCli-1.19.004/credentials" >> /root/.profile
#RUN chmod 600 /RDSCli-1.19.004/credentials

RUN yum install -y groff
RUN easy_install pip
RUN pip install awscli


#
# Setup S3
# ---------

RUN wget https://github.com/s3tools/s3cmd/archive/master.zip
RUN unzip /master.zip
RUN cd /s3cmd-master; python setup.py install
RUN yum install -y python-dateutil

ADD ./s3cfg /.s3cfg


#
# Install cron and batches
# ------------------------

# Add batches here since it changes often (use cache when building)
#ADD ./batches.py /
ADD ./batches.sh /

ADD ./recalc_privileges.php /var/www/html/vtigercrm/recalc_privileges.php
#RUN  /var/www/html/vtigercrm/recalc_privileges.php

# Shouldn't have to disable/enable CikabTroubleTicket manually with this
ADD ./src-vtiger/parent_tabdata.php /var/www/html/vtigercrm/
ADD ./src-vtiger/tabdata.php /var/www/html/vtigercrm/

# Run backup job every hour
ADD ./backup.sh /
RUN echo '0 1 * * *  /bin/bash -c "/backup.sh"' > /mycron

# Run job every minute
RUN echo '*/1 * * * *  /bin/bash -c "/batches.sh"' >> /mycron

#RUN crontab /mycron

#ADD ./etc-pam.d-cron /etc/pam.d/cron


#
# Start apache and mysql using supervisord
# -----------------------------------------

# Fix permissions
#RUN chown -R www-data:www-data /var/www/html


EXPOSE 80 443
CMD ["supervisord"]
