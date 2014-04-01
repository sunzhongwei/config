/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com

How to test:
$ for i in {1..200}; do nohup curl localhost:8888 >/dev/null 2>&1 & done
*/

package main

import (
	"fmt"
	"net/http"
	"time"
)

func indexHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Start at:", time.Now())
	time.Sleep(5 * time.Second)
	fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
	fmt.Println("End at:", time.Now())
}

func redirectHandler(w http.ResponseWriter, r *http.Request) {
	// curl -IL --max-redirs 10 --max-time 10 http://localhost:8888/redirect
	fmt.Println("redirect")
	http.Redirect(w, r, "http://www.dnspod.com", http.StatusMovedPermanently)
	//http.Redirect(w, r, "/redirect", http.StatusMovedPermanently)
}

func main() {
	port := 8888
	fmt.Println("Start server on port:", port)
	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/redirect", redirectHandler)
	http.ListenAndServe(fmt.Sprintf(":%v", port), nil)
}
