vTiger container
=================

1. Create `src-vtiger/config.inc.php` from the template and update `$site_URL`. 

There is some logging that typically varies between development and production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`

2. Build the container: `docker build --rm -t vtiger .`

3. Start a container: `docker run -d -p 80:80 -e db_server="localhost" -e db_port=":3306" -e db_username="vtigerdemo" -e db_password="vtigerdemo" -e db_name="vtigerdemo" --name vtiger vtiger`.
 Replace the credentials with your db credentials

When using [fig](http://fig.sh) just do `fig up` and containers with the test dbs will be launched. 
See `fig.yml` for the configurations.


Development environemnet
-----------------------

Login to MySQL using phpMyAdmin at: `http://localhost:PORT/phpMyAdmin-4.0.8-all-languages`


It is usefull to connect with a shell when debugging: 
1. `docker run -t -i -p 80:80 -e db_server="localhost" -e db_port=":3306" -e db_username="vtigerdemo" 
-e db_password="vtigerdemo" -e db_name="vtigerdemo" vtiger /bin/bash`

When using [fig](http://fig.sh) just do `fig run demo /bin/bash` and containers with the test dbs will be launched. 
See `fig.yml` for the configurations.

2. Then start things up with: `supervisord &> /tmp/out.txt &`

PHP is installed in the folder : `/opt/src/phpfarm`


Credentials
-----------

 * vtigerdemo - admin/admin
 

Image backups
-------------

The vtiger docker image takes some time to build. It is sometimes good to save a backup of the image.

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


