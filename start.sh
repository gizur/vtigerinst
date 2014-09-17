#!/bin/bash
supervisord &

sleep 5

# Fix permissions for log file, vTiger will complain otherise
chmod 0222 /var/log/supervisor/supervisord.log

# Fix permissions (will run every minute)
/var/www/html/vtigercrm/recalc_privileges.php >> /var/log/supervisor/supervisord.log

tail -f /var/log/supervisor/supervisord.log -f /var/log/mysql/error.log