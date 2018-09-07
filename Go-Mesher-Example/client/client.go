package main

import (
	"fmt"
	"github.com/tedsuo/rata"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"
	"sync"
)

var (
	destination = ""
)

func main() {
	petRoutes := rata.Routes{
		{Name: "latency", Method: rata.GET, Path: "/TestLatency"},
		{Name: "error", Method: rata.GET, Path: "/TestErrors"},
	}
	petHandlers := rata.Handlers{
		"latency": &LatencyHandler{},
		"error":   &ErrorHandler{},
	}
	router, err := rata.NewRouter(petRoutes, petHandlers)
	if err != nil {
		panic(err)
	}
	providerName, isExsist := os.LookupEnv("PROVIDER_NAME")
	if isExsist {
		fmt.Println("Provider Name:" ,providerName);
		destination = providerName
	}
	dat, _ := ioutil.ReadFile("conf/app.conf")
	confArray := strings.Split(string(dat), "\n")

	providerArray := strings.Split(confArray[0], "=")
	if providerArray[1] != "" {
		fmt.Println("Provider Array", providerArray[1]);
		destination = providerArray[1]

	} else {
		providerAddr, isExsist := os.LookupEnv("PROVIDER_ADDR")
		if isExsist {
			destination = providerAddr
		} else {
			fmt.Println("Please configure PROVIDER_ADDR in app.conf or env variable")
			os.Exit(1)
		}
	}

	httpproxyAddr, isExsist := os.LookupEnv("http_proxy")
	if isExsist {
		os.Setenv("http_proxy", httpproxyAddr)
	}

	// The router is just an http.Handler, so it can be used to create a server in the usual fashion:
	fmt.Println("Client Started on 3000 port")
	err = http.ListenAndServe(":3000", router)
	if err != nil {
		log.Fatal(err)
	}
}

var status int = 200
var mu sync.RWMutex

type ErrorHandler struct {
}

func doGet(api string, w http.ResponseWriter) {

	req, err := http.NewRequest(http.MethodGet, destination+api, nil)
	fmt.Println("API + Desti", destination+api);
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(err.Error()))
		return
	}
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(err.Error()))
		return
	}
	if resp == nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte("Resp is nil"))
		return
	}
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(err.Error()))
		return
	}
	w.WriteHeader(resp.StatusCode)
	w.Write(body)
	return
}
func (e *ErrorHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Serving /errors request ")
	doGet("/errors", w)
}

type LatencyHandler struct {
}

func (e *LatencyHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Serving /latency request")
	doGet("/latency", w)
}
