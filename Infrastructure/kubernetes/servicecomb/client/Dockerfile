FROM golang:1.10.2 as builder
WORKDIR /go/src/github.com/go-mesh/mesher-tools/
COPY client.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o client .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/go-mesh/mesher-tools/client .
ENTRYPOINT ["./client"]