package main

import (
	"flag"
	"io/ioutil"
	"log"
	"net/http"
	"strings"
)

func main() {
	url := flag.String("url", "url", "The url to call")
	flag.Parse()
	if !strings.Contains(*url, "http") {
		*url = "http://" + *url
	}
	resp, err := http.Get(*url)
	if err != nil {
		log.Println(err)
		return
	}
	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	log.Println(string(body))
	log.Println()
	log.Println()
	log.Println(resp)
}
