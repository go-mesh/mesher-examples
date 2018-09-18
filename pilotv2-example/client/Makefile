SHELL := /bin/bash

all: binary docker distribute restart

binary:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags '-w' -o ./build/pilotv2client

docker: binary
	docker build -t go-chassis/pilotv2client:latest ./build

distribute:
	./build/distribute-image.sh go-chassis/pilotv2client:latest

restart:
	-kubectl delete -f ./build/
	kubectl apply -f ./build/

