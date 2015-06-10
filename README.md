vTiger container
=================


Clone this repo into a [LAMP container](https://github.com/colmsjo/docker-lamp).

1. Create the MySQL database: `./src-mysql/mysql-setup.sh`

1. Update `src-vtiger/config.inc.php`. This variable needs to be changed:
`$site_URL = 'http://localhost:8080/vtigercrm';`

There is also some logging that typically varies between development and
production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`

2. Copy `env.list.template` to `env.list` and update. Run `source env.list` to
   set the environment variables.

3. Setup batches:

```
   # Run job every minute
   echo '*/1 * * * *  /bin/bash -c "/batches.sh"' >> /mycron
   RUN crontab /mycron
```

4. Run `/var/www/html/vtigercrm/recalc_privileges.php` manually
  (to be on the safe side)

5. Open `http://[DOCKER_IP]/vtigercrm`. Cikab's seasonportal is setup using [this repo](https://github.com/gizur/cikab)

6. disconnect with `ctrl-p` `ctrl-q`


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
