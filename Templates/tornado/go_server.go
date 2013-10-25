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

func main() {
	port := 8889
	fmt.Println("Start server on port:", port)
	http.HandleFunc("/", indexHandler)
	http.ListenAndServe(fmt.Sprintf(":%v", port), nil)
}
