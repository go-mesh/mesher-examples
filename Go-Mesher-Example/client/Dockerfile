FROM golang:latest
ADD . /go/src/github.com/go-mesh/mesher-examples/Go-Mesher-Example/client
WORKDIR /go/src/github.com/go-mesh/mesher-examples/Go-Mesher-Example/client
RUN go get github.com/tedsuo/rata
RUN go install github.com/go-mesh/mesher-examples/Go-Mesher-Example/client
ENTRYPOINT /go/bin/client
EXPOSE 3000
