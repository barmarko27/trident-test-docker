#!/bin/bash

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Network Creation...                                     *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
sh ./provisioning/create-network.sh

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Launching MariaDB...                                    *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./mariadb-container/docker-compose.yml up -d

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Launching PHP 72...                                     *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./php7-container/docker-compose.yml up -d

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Launching NGINX...                                      *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./nginx-container/docker-compose.yml up -d

cd www-data;

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* CLONING APP...                                          *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
git clone git@github.com:barmarko27/trident-test-app.git

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* INSTALLING APP...                                       *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; mv .env.dist .env; mkdir -p config/jwt;';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; openssl genpkey -out config/jwt/private.pem -aes256 -algorithm rsa -pkeyopt rsa_keygen_bits:4096 -pass pass:$JWTPWD;';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; openssl pkey -in config/jwt/private.pem -out config/jwt/public.pem -pubout -passin pass:$JWTPWD';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; sed -i -- "s/%APPSECRET%/9uijhgfrghvcf/g" .env; sed -i -- "s/%APPENV%/dev/g" .env; sed -i -- "s/%JWT_PASSPHRASE%/$JWTPWD/g" .env;';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; sed -i -- "s/%MYSQL_DB_USER%/$MYSQL_DB_USER/g" .env; sed -i -- "s/%MYSQL_DB_PASSWORD%/$MYSQL_DB_PASSWORD/g" .env; sed -i -- "s/%MYSQL_DB_HOST%/$MYSQL_DB_HOST/g" .env; sed -i -- "s/%MYSQL_DB_PORT%/$MYSQL_DB_PORT/g" .env; sed -i -- "s/%MYSQL_DB_NAME%/$MYSQL_DB_NAME/g" .env; sed -i -- "s/%MYSQL_VERSION%/$MYSQL_VERSION/g" .env;';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; composer install';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; php bin/console doctrine:database:drop --force && php bin/console doctrine:database:create';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; php bin/console doctrine:migrations:migrate';

docker exec -ti php7_trident /bin/bash -c 'cd /var/www/trident-test-app; php bin/console doctrine:fixtures:load';