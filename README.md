vTiger container
=================


Quick installation
------------------

1. `docker build --rm --no-cache -t vtiger .`
1. The docker build sometimes fail due to network errors etc. Repeat
`docker build --rm -t vtiger .` until the build succeeds.
1. Start a container:
    docker run -d -p 80:80 -e db_server="localhost" -e db_port=":3306" \
    -e db_username="vtigerdemo" -e db_password="vtigerdemo" \
    -e db_name="vtigerdemo" --name vtiger vtiger`

1. Check the log files: `docker logs vtiger`
1. Open `http://[DOCKER_IP]/vtigercrm`

Cikab's seasonportal is setup using [this repo](https://github.com/gizur/cikab)


Full setup
----------

1. Update `src-vtiger/config.inc.php`. This variable needs to be changed:
`$site_URL = 'http://localhost:8080/vtigercrm';`

There is also some logging that typically varies between development and production:

 * `error_reporting` in `php.ini`.
 *  `'LOG4PHP_DEBUG' => ...,` in `config.performance.php`

2. Build the container: `docker build --rm -t vtiger .`

3. Start a container:

    docker run -t -i -p 80:80 -e db_server="localhost" -e db_port=":3306" \
    -e db_username="xxx" -e db_password="xxx" -e db_name="xxx" \
    -h vtiger[cikab|clab] --restart="on-failure:10" \
    --link beservices:beservices --name vtiger vtiger \
    /bin/bash -c "supervisord; bash"

  Replace `xxx` with your db credentials. Disconnect with `ctrl-p` `ctrl-q`

4. Then start things up with: `supervisord`


Login to MySQL using phpMyAdmin at:
`http://localhost:PORT/phpMyAdmin-4.0.8-all-languages`

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


MySQL performance tuning
------------------------

The Percona Toolkit is installed in the container. These tools works with the
local MySQL process. They cannot be used for Amazon RDS.

The RDS Command Line tools are also installed. Update `/RDSCli-1.19.00/credentials`
with your API Key and Secret. Make sure that this user has the necessary IAM
Policy. Then run `rds-describe-db-instances` to verify that things work.
See the
[documentation](http://docs.aws.amazon.com/AmazonRDS/latest/CommandLineReference/Welcome.html)
for more details. A parameter needs to be changed in RDS in order to generate the
[slow query logs](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.Concepts.MySQL.html).
Changing parameters should be done with care. Make sure to test all settings in
a non-production database first.
