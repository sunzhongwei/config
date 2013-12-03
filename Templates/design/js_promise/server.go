/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com
*/

package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type Response map[string]interface{}

func (r Response) toString() (s string) {
	b, err := json.Marshal(r)
	if err != nil {
		s = ""
		return
	}
	s = string(b)
	return
}

func ApiHandler(w http.ResponseWriter, r *http.Request) {
	startTime := time.Now()
	apiID := r.URL.Path[len("/api/"):]
	timeString := fmt.Sprintf("%vs", apiID)
	fmt.Println("Sleep", timeString)
	duration, _ := time.ParseDuration(timeString)
	time.Sleep(duration)
	endTime := time.Now()
	ret := fmt.Sprintf("OK %v. Start at: %v. End at: %v.", apiID,
		startTime.Format("2006-01-02 15:04:05"),
		endTime.Format("2006-01-02 15:04:05"))
	fmt.Fprintf(w, Response{"ret": ret}.toString())
}

func main() {
	http.Handle("/", http.FileServer(http.Dir("./")))
	http.HandleFunc("/api/", ApiHandler)
	http.ListenAndServe(":8888", nil)
}
