#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd /var/www/html/; tar -xvzf $DIR/vtigercrm-installed.tgz; cd $DIR

# Customized to fetch db credentials from environment variables
cp ./src-vtiger/config.inc.php /var/www/html/vtigercrm/
cp ./src-vtiger/config.performance.php /var/www/html/vtigercrm/
cp ./src-vtiger/log4php.properties /var/www/html/vtigercrm/


# --------------------------------------------------------------------

# Install vTiger, the installation script will run the first time
# Use the vtiger/vtiger/vtiger credentials (empty db)
#tar -xvzf ./vtigercrm-5.4.0.tar.gz /var/www/html/

# --------------------------------------------------------------------


# Cikab customizations
cp -r ./src-vtiger/cikab/CikabTroubleTicket /var/www/html/vtigercrm/modules/CikabTroubleTicket
cp ./src-vtiger/cikab/soap/customerportal.php /var/www/html/vtigercrm/soap/customerportal.php
cp ./src-vtiger/include-Webservice-LoginCustomer.php /var/www/html/vtigercrm/include/Webservices/LoginCustomer.php

cp ./batches.sh /vtiger-batches.sh

cp ./recalc_privileges.php /var/www/html/vtigercrm/recalc_privileges.php
/var/www/html/vtigercrm/recalc_privileges.php

# Shouldn't have to disable/enable CikabTroubleTicket manually with this
cp ./src-vtiger/parent_tabdata.php /var/www/html/vtigercrm/
cp ./src-vtiger/tabdata.php /var/www/html/vtigercrm/

# Run backup job every hour
cp ./backup.sh /vtiger-backup.sh
echo '0 1 * * *  /bin/bash -c "/vtiger-backup.sh"' > /mycron

# Run job every minute
echo '*/1 * * * *  /bin/bash -c "/vtiger-batches.sh"' >> /mycron

#crontab /mycron
