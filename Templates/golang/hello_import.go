/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com
*/

package main

import (
	e "errors" // alias
	. "fmt"    // 可以省去包名
	_ "os"     // just call init func of os package
)

func main() {
	Println("Hello world")

	err := e.New("test err")
	Println(err)
}
