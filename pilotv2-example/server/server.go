package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
	"sync"
	"time"

	"github.com/tedsuo/rata"
)

func main() {
	petRoutes := rata.Routes{
		{Name: "latency", Method: rata.GET, Path: "/latency"},
		{Name: "error", Method: rata.GET, Path: "/errors"},
		{Name: "latency2", Method: rata.POST, Path: "/latency/:duration"},
		{Name: "error2", Method: rata.POST, Path: "/errors/:status"},
	}
	petHandlers := rata.Handlers{
		"latency":  &LatencyHandler{},
		"error":    &ErrorHandler{},
		"latency2": &LatencyHandler2{},
		"error2":   &ErrorHandler2{},
	}
	router, err := rata.NewRouter(petRoutes, petHandlers)
	if err != nil {
		panic(err)
	}

	// The router is just an http.Handler, so it can be used to create a server in the usual fashion:
	fmt.Println("Server started succesfully at 3001 port ")
	_ = http.ListenAndServe("0.0.0.0:3001", router)

}

var status int = 500
var mu sync.RWMutex

type ErrorHandler struct {
}

func (e *ErrorHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	mu.RLock()
	w.WriteHeader(status)
	fmt.Println("Error in serving the response")
	fmt.Println(w)
	mu.RUnlock()
}

type ErrorHandler2 struct {
}

func (e *ErrorHandler2) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	mu.Lock()
	s := r.URL.Query().Get(":status")
	status, _ = strconv.Atoi(s)
	fmt.Println("Error in serving the response")
	fmt.Println(status)
	mu.Unlock()
}

var latency string = "100ms"

type LatencyHandler struct {
}

func (e *LatencyHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	mu.RLock()
	d, _ := time.ParseDuration(latency)
	time.Sleep(d)
	mu.RUnlock()
	hostname, _ := os.Hostname()

	w.Write([]byte("The Latency for this request is : " + d.String() + "\n" +
		"The host serving this request is " + hostname + " and the IP is " + GetOutboundIP().String()))
	fmt.Println("Serving the response for /latency")
}

type LatencyHandler2 struct {
}

func (e *LatencyHandler2) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	mu.Lock()
	latency = r.URL.Query().Get(":duration")
	d, _ := time.ParseDuration(latency)
	time.Sleep(d)
	mu.Unlock()
	hostname, _ := os.Hostname()
	w.Write([]byte("The Latency for this request is : " + d.String() + "\n" +
		"The host serving this request is " + hostname + " and the IP is " + GetOutboundIP().String()))
	fmt.Println("Serving the response for /latency with parameters")
}

func GetOutboundIP() net.IP {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	localAddr := conn.LocalAddr().(*net.UDPAddr)

	return localAddr.IP
}
