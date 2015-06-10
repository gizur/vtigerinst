vTiger container
=================


Clone this repo into a [LAMP container](https://github.com/colmsjo/docker-lamp).
See the README of the LAMP container for instructions.

1. Setup environment variables for apache. Edit
`/etc/supervisor/conf.d/supervisor.conf` based on `env.list` and do
`supervisorctl update`. Open http://[IP]:[PORT]/info.php and validate the
environment variables.

2. Create the MySQL database: ` cd /src-mysql; ./mysql-setup.sh`

3. Update `src-vtiger/config.inc.php`. This variable needs to be changed:
`$site_URL = 'http://localhost:8080/vtigercrm';`

There is also some logging that typically varies between development and
production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`

4. Setup batches:

```
   # Run job every minute
   echo '*/1 * * * *  /bin/bash -c "/batches.sh"' >> /mycron
   RUN crontab /mycron
```

5. Run `/var/www/html/vtigercrm/recalc_privileges.php`

6. Open `http://[DOCKER_IP]/vtigercrm`. Cikab's seasonportal is setup using
[this repo](https://github.com/gizur/cikab)

7. disconnect with `ctrl-p` `ctrl-q`


vTiger Credentials
------------------

 * vtigerdemo - admin/admin
 * vtiger_5159ff6a - admin/frefug4staY7
 * clabgizurcom - admin / st4vaDas3ecE


Setup Outgoing Mail
-------------------

Update `CRM Settings->Outgoing Server` with the gmail credentials:

	Server Name:				ssl://smtp.gmail.com:465
	User Name:					noreply@gizur.com
	Password:					******  
	From Email:					noreply@gizur.com
	Requires Authentication?:	Yes
