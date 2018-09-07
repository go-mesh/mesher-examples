FROM golang:1.10.2 as builder
WORKDIR /go/src/github.com/go-mesh/mesher-tools/
COPY server.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/go-mesh/mesher-tools/server .
ENTRYPOINT ["./server"]