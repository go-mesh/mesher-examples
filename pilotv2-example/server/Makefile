SHELL := /bin/bash

all: binary docker distribute restart

binary:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags '-w' -o ./build/pilotv2server

docker: binary
	docker build -t go-chassis/pilotv2server:latest ./build

distribute:
	./build/distribute-image.sh go-chassis/pilotv2server:latest

restart:
	- kubectl delete -f ./build/k8s/
	- kubectl apply -f ./build/k8s/
