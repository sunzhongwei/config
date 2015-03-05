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

func MemberHandler(w http.ResponseWriter, r *http.Request) {
	ret := ` 
    {
   		"code": 0,
  		"msg": "OK",
   		"data": {
     		"id": 1,
     		"name": "zhongwei"
   		}
 	}
	`
	fmt.Fprintf(w, ret)
}

func main() {
	http.Handle("/", http.FileServer(http.Dir("./")))
	http.HandleFunc("/member", MemberHandler)
	fmt.Println("Server is running on port 9999.")
	http.ListenAndServe(":9999", nil)
}
