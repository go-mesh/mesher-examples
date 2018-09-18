SHELL := /bin/bash

all: docker tar
	distribute-image.sh go-chassis/provider-mesher:latest

tar:
	# CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags '-w' -o ./build/pilotv2server
	tar zcf mesher.tar.gz mesher conf

docker: tar
	docker build -t go-chassis/provider-mesher:latest ./


