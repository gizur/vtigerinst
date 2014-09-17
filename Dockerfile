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

FROM     ubuntu:latest
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

RUN echo "export HOME=/root" >> /root/.profile

RUN apt-get update
RUN apt-get install -y wget nano curl git


#
# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools
RUN easy_install supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/



#
# Install Apache
# ---------------

RUN apt-get install -y apache2
RUN a2enmod rewrite status
ADD ./etc-apache2-apache2.conf /etc/apache2/apache2.conf
ADD ./etc-apache2-mods-available-status.conf /etc/apache2/mods-available/status.conf

RUN rm /var/www/html/index.html
RUN echo "<?php\nphpinfo();\n " > /var/www/html/info.php


#
# Install MySQL
# -------------

# Install scripts
ADD ./src-mysql /src-mysql

# Add source code for SQL-scripts and vTiger instances
#ADD ./src-instances /src-instances

# Install MySQL server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix configuration
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user and load data
RUN /src-mysql/mysql-setup.sh


#
# Use phpfarm to manage PHP versions
# ----------------------------------
#
# Add one script per PHP version and update 

# Preparations
RUN apt-get update
RUN apt-get install -y libxml2-dev libbz2-dev libmcrypt-dev libxslt1-dev libssl-dev libsslcommon2-dev libapr1-dev libaprutil1-dev libreadline-dev make libcurl4-openssl-dev libjpeg-dev libpng12-dev libfreetype6-dev libxpm-dev libgd-dev libxpm4 t1lib-bin libtidy-dev libc-client-dev

# Fix problem with libs in wrong place
RUN ln -s /usr/lib/x86_64-linux-gnu/libXpm* /usr/lib/
RUN ln -s /usr/lib/x86_64-linux-gnu/libkrb5* /usr/lib/
RUN ln -s /usr/lib/x86_64-linux-gnu/libfreetype* /usr/lib/

# Install PHP farm
RUN cd /opt; git clone git://git.code.sf.net/p/phpfarm/code phpfarm
ADD ./options.sh /opt/phpfarm/src/options.sh
RUN cd /opt/phpfarm/src; ./compile.sh 5.3.27
ADD ./var-www-html-cgibin-phpcgi-5.3.27 /var/www/cgibin/phpcgi-5.3.27
ADD ./opt-phpfarm-inst-php-5.3.27-lib-php.ini /opt/phpfarm/inst/php-5.3.27/lib/php.ini 


# Manage PHP versions in Apache using FastCGI - old libapache2-mod-fastcgi 
RUN apt-get install -y apache2-mpm-worker apache2-suexec libapache2-mod-fcgid
RUN a2enmod actions fcgid suexec
ADD ./etc-apache2-sites-available-000-default.conf /etc/apache2/sites-available/000-default.conf

# Install phpMyAdmin
ADD ./src-phpmyadmin/phpMyAdmin-4.0.8-all-languages.tar.gz /var/www/html/
ADD ./src-phpmyadmin/config.inc.php /var/www/html/phpMyAdmin-4.0.8-all-languages/config.inc.php

# Either use pre-configured vTiger, or standard installation package
# --------------------------------------------------------------------

# Install vTiger, use the files produced from the installation script
ADD ./vtigercrm-installed.tgz /var/www/html/

# Cusomized to fetch db credentials from environment variables
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


# Tests
ADD ./test /test
#RUN /test/setup.sh

#
# Start apache and mysql using supervisord
# -----------------------------------------

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Create a volume
RUN mkdir /volume
VOLUME ["/volume"]

# Add batches here since it changes often (use cache whrn building)
ADD ./batches.py /
ADD ./batches.sh /
ADD ./recalc_privileges.php /var/www/html/vtigercrm/recalc_privileges.php

ADD ./start.sh /

EXPOSE 80 443
CMD ["/start.sh"]
