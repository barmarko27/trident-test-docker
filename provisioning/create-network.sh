#!/bin/bash

echo ""
echo "***********************************************************"
echo "*                                                         *"
echo "* Creazione network Trident Test ...                      *"
echo "*                                                         *"
echo "***********************************************************"
echo ""

MY_SUBNET="192.168.40.0/25";

MY_GATEWAY="192.168.40.1";

MY_GATEWAY="192.168.40.1";

MY_NETWORK="trident_test_ntw";

REMOVE="$(docker network rm $MY_NETWORK)" >> /dev/null

MY_NETWORK_UID="$(docker network create -d bridge --subnet=$MY_SUBNET --gateway=$MY_GATEWAY $MY_NETWORK)" >> /dev/null

echo "UID della network: $MY_NETWORK_UID"

MY_IP="$(ifconfig en0 | awk '$1 == "inet" {print $2}')"

echo "Ip da inserire nel file /etc/hosts: $MY_IP"

echo ""