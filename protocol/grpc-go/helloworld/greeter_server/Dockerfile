FROM golang:1.11
ADD . /go/src/github.com/go-mesh/mesher-examples/protocol/grpc-go/helloworld/greeter_server
WORKDIR /go/src/github.com/go-mesh/mesher-examples/protocol/grpc-go/helloworld/greeter_server

RUN go install github.com/go-mesh/mesher-examples/protocol/grpc-go/helloworld/greeter_server
ENTRYPOINT /go/bin/greeter_server
