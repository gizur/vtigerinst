vTiger container
=================


Clone this repo into a [LAMP container](https://github.com/colmsjo/docker-lamp).
See the README of the LAMP container for instructions.

1. Setup environment variables for apache. Edit
`/etc/supervisor/conf.d/supervisor.conf` based on `env.list` and do
`supervisorctl update`. Open http://[IP]:[PORT]/info.php and validate the
environment variables. Also set the environment variables for the current bash
session: `set -a; . env.list`. Save this with: `export > /env`

2. Delete `info.php` or rename it to a long random string (it contains sensitive
  information)

3. Create the MySQL database: ` cd src-mysql; ./mysql-setup.sh`

4. Update `src-vtiger/config.inc.php`. This variable needs to be changed:
`$site_URL = 'http://localhost:8080/vtigercrm';`

There is also some logging that typically varies between development and
production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`
 *  `'log4php.rootLogger=DEBUG/FATAL/...,A1' => ...,` in `log4php.properties`

5. Setup batches (this should only be performed on one server if there are
  several application servers):

```
   # Run job every minute
   echo '*/1 * * * *  /bin/bash -c "/batches.sh"' >> /mycron
   crontab /mycron
```

6. Run: `./setup.sh`

7. Run `/var/www/html/vtigercrm/recalc_privileges.php`

8. Open `http://[DOCKER_IP]/vtigercrm`. Cikab's seasonportal is setup using
[this repo](https://github.com/gizur/cikab). Clab's trailerapp portal is
setup using [this repo](https://github.com/gizur/clab).

9. Enable and disable the assets module: CRM Settings->Module Manager
(workaround for a bug in vtiger).

10. disconnect with `ctrl-p` `ctrl-q`


Setup Outgoing Mail
-------------------

Update `CRM Settings->Outgoing Server` with the gmail credentials:

	Server Name:				ssl://smtp.gmail.com:465
	User Name:					noreply@gizur.com
	Password:					******  
	From Email:					noreply@gizur.com
	Requires Authentication?:	Yes
