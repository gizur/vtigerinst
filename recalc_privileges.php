#!/usr/bin/php
<?php
chdir('/var/www/html/vtigercrm/');
require_once('config.inc.php');

echo "Recalculating all privileges...";
require_once('vtlib/Vtiger/Access.php');
Vtiger_Access::syncSharingAccess();

?>
