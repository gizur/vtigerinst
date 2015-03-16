vTiger container
=================


Quick installation
------------------

1. `docker build --rm --no-cache -t vtiger .``
1. The docker build sometimes fail due to network errors etc. Repeat
`docker build --rm -t vtiger .` until the build succeeds.
1. Start a container: `docker run -d -p 80:80 -e db_server="localhost" -e db_port=":3306" -e db_username="vtigerdemo" -e db_password="vtigerdemo" -e db_name="vtigerdemo" --name vtiger vtiger`
1. Check the log files: `docker logs vtiger`
1. Open http://[DOCKER_IP]/vtigercrm

Cikab's seasonportal is setup using [this repo](https://github.com/gizur/cikab)


Full setup
----------

1. Update `src-vtiger/config.inc.php` with MySQL credentials and web server configuration.
The defaults should be ok for development but should be changed for production.
There are three different database dumps for development. See `src-mysql/mysql-setup.sh`
for credentials. This variable also needs to be changed: `$site_URL = 'http://localhost:8080/vtigercrm';``

There is some logging that typically varies between development and production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`

2. Build the container: `docker build --rm -t vtiger .`

3. Start a container: `docker run -d -p 80:80 -e db_server="localhost" -e db_port=":3306" -e db_username="vtigerdemo" -e db_password="vtigerdemo" -e db_name="vtigerdemo" --name vtiger vtiger`.
 Replace the credentials with your db credentials

4. Start a container: `docker run -d -p 80:80 -e db_server="localhost" -e db_port=":3306" -e db_username="xxx" -e db_password="xxx" -e db_name="xxx" --name vtiger vtiger`.
Replace `xxx` with your db credentials



Development environment
-----------------------

Login to MySQL using phpMyAdmin at: `http://localhost:PORT/phpMyAdmin-4.0.8-all-languages`

It is usefull to connect with a shell when debugging:

1. `docker run -t -i -p 80:80 -e db_server="localhost" -e db_port=":3306" -e db_username="vtigerdemo"
-e db_password="vtigerdemo" -e db_name="vtigerdemo" vtiger /bin/bash`

2. Then start things up with: `supervisord &> /tmp/out.txt &`

PHP is installed in the folder : `/opt/src/phpfarm`


vTiger Credentials
------------------

 * vtigerdemo - admin/admin


Image backups
-------------

The vtiger docker image takes some time to build. It is sometimes good to save
a backup of the image.

	>docker save vtiger > vtiger-dockcer.tar
	>gzip vtiger-dockcer.tar
	>docker load vtiger-docker.tar


Setup Outgoing Mail
-------------------

Update `CRM Settings->Outgoing Server` with the gmail credentials:

	Server Name:				ssl://smtp.gmail.com:465
	User Name:					noreply@gizur.com
	Password:					******  
	From Email:					noreply@gizur.com
	Requires Authentication?:	Yes
