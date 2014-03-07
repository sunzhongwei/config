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

func ContactsHandler(w http.ResponseWriter, r *http.Request) {
	ret := ` 
	{
		"ecode": 0,
		"msg": "ok",
		"data": [
			{"name": "zhongwei", "num": "13829292923"},
			{"name": "wukong", "num": "1232339284"}
		] 
	}
	`
	fmt.Fprintf(w, ret)
}

func Contacts500Handler(w http.ResponseWriter, r *http.Request) {
	ret := ` 
	{
		"ecode": 0,
		"msg": "ok",
		"data": [
			{"name": "zhongwei", "num": "13829292923"},
			{"name": "wukong", "num": "1232339284"}
		] 
	}
	`
	w.WriteHeader(500)
	fmt.Fprintf(w, ret)
}

func ContactsRetCodeHandler(w http.ResponseWriter, r *http.Request) {
	ret := ` 
	{
		"ecode": 65535,
		"msg": "db error",
		"data": [
		] 
	}
	`
	fmt.Fprintf(w, ret)
}

func main() {
	http.Handle("/", http.FileServer(http.Dir("./")))
	http.HandleFunc("/contacts", ContactsHandler)
	http.HandleFunc("/contacts-500", Contacts500Handler)
	http.HandleFunc("/contacts-ret-code", ContactsRetCodeHandler)
	fmt.Println("Server is running on port 8888.")
	http.ListenAndServe(":8888", nil)
}
