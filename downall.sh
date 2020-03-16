#!/bin/bash

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Shutdown MariaDB...                                     *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./mariadb-container/docker-compose.yml down

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Shutdown PHP 72...                                      *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./php7-container/docker-compose.yml down

echo
echo "***********************************************************"
echo "*                                                         *"
echo "* Shutdown NGINX...                                       *"
echo "*                                                         *"
echo "***********************************************************"
echo ""
echo ""
echo ""
docker-compose -f ./nginx-container/docker-compose.yml down