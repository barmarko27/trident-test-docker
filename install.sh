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
echo "* Launching PHP 72...                                     *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./php72-container/docker-compose.yml up -d

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
docker exec -ti php72_trident /bin/bash -c 'cd /var/www/trident-test-app; composer install'