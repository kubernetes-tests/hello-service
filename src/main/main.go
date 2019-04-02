package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/hello/", home)
	http.HandleFunc("/hello/info", hello)
	http.HandleFunc("/hello/path", path)
	http.ListenAndServe(":3000", nil)
}

func home(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Home")
}

func hello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "hello world! from version 1")
}

func path(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "This is your path")
	fmt.Fprintln(w, r.URL.Path)
}
