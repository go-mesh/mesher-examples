#!/usr/bin/env bash
cp -r ./vendor ./greeter_client/
cp -r ./vendor ./greeter_server/

sudo docker-compose up