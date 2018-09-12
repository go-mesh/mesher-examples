#!/bin/sh

# CMDVAR="-Djava.security.egd=file:/dev/./urandom","java -agentlib:jdwp=transport=dt_socket,address=0:8000,server=y,suspend=n -jar"
java $CMDVAR \
-Dcse.service.registry.address="${REGISTRY:-"http://127.0.0.1:30100"}" \
-jar ./provider-0.0.1-SNAPSHOT.jar
