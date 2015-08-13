vTiger container
=================


Clone this repo into a [LAMP container](https://github.com/colmsjo/docker-lamp).
See the README of the LAMP container for instructions.

1. Setup environment variables for apache. Edit
`/etc/supervisor/conf.d/supervisor.conf` based on `env.list` and do
`supervisorctl update`. Open http://[IP]:[PORT]/info.php and validate the
environment variables. Also set the environment variables for the current bash
session: `set -a; . env.list`. Save this with: `export > /env`

2. Create the MySQL database: ` cd src-mysql; ./mysql-setup.sh`

3. Update `src-vtiger/config.inc.php`. This variable needs to be changed:
`$site_URL = 'http://localhost:8080/vtigercrm';`

There is also some logging that typically varies between development and
production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`
 *  `'log4php.rootLogger=DEBUG/FATAL/...,A1' => ...,` in `log4php.properties`

4. Setup batches (this should only be performed on one server if there are
  several application servers):

```
   # Run job every minute
   echo '*/1 * * * *  /bin/bash -c "/batches.sh"' >> /mycron
   crontab /mycron
```

5. Run: `./setup.sh`

6. Run `/var/www/html/vtigercrm/recalc_privileges.php`

7. Open `http://[DOCKER_IP]/vtigercrm`. Cikab's seasonportal is setup using
[this repo](https://github.com/gizur/cikab). Clab's trailerapp portal is
setup using [this repo](https://github.com/gizur/clab).

8. Enable and disable the assets module: CRM Settings->Module Manager
(workaround for a bug in vtiger).

9. disconnect with `ctrl-p` `ctrl-q`


vTiger Credentials
------------------

 * vtigerdemo - admin/admin
 * vtiger_5159ff6a - admin/frefug4staY7
 * clabgizurcom - admin / st4vaDas3ecE


MySQLprod setup
-----------------

gc1-mysql1.cjd3zjo5ldyz.eu-west-1.rds.amazonaws.com:3306
RDS instance: gc1-mysql1
root / s0C55vtKKNcV
clabgizurcom/ il2xiTtjKG30


Setup Outgoing Mail
-------------------

Update `CRM Settings->Outgoing Server` with the gmail credentials:

	Server Name:				ssl://smtp.gmail.com:465
	User Name:					noreply@gizur.com
	Password:					******  
	From Email:					noreply@gizur.com
	Requires Authentication?:	Yes
