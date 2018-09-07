package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

var myClient *http.Client

func init() {
	defaultRoundTripper := http.DefaultTransport
	defaultTransportPointer, ok := defaultRoundTripper.(*http.Transport)
	if !ok {
		panic(fmt.Sprintf("defaultRoundTripper not an *http.Transport"))
	}
	defaultTransport := *defaultTransportPointer // dereference it to get a copy of the struct that the pointer points to
	defaultTransport.MaxIdleConns = 100
	defaultTransport.MaxIdleConnsPerHost = 100

	myClient = &http.Client{Transport: &defaultTransport}

}
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		resp, err := myClient.Get(os.Getenv("TARGET"))
		log.Println(os.Getenv("TARGET"))
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		if resp == nil {
			w.WriteHeader(500)
			return
		}

		b := make([]byte, 0)
		_, _ = resp.Body.Read(b)
		resp.Body.Close()
		w.Write(b)

	})
	http.ListenAndServe(":9000", nil)
}
