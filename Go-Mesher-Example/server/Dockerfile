FROM golang:latest
ADD . /go/src/github.com/go-mesh/mesher-examples/Go-Mesher-Example/server
WORKDIR /go/src/github.com/go-mesh/mesher-examples/Go-Mesher-Example/server
RUN go get github.com/tedsuo/rata
RUN go install github.com/go-mesh/mesher-examples/Go-Mesher-Example/server
ENTRYPOINT /go/bin/server
EXPOSE 3000
