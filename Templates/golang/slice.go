/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com
*/

package main

import (
	"fmt"
)

func main() {
	fmt.Println("array 为定长，而 slice 为非定长. 所以 slice 要自由的多，程序中更多使用 slice.")

	// array
	var a [4]int
	fmt.Println("指定长度 var a [4]int ->", a)

	b := [2]string{"foo", "bar"}
	fmt.Println(b)

	c := [...]string{"a", "b", "c"}
	fmt.Println("编译器自动设置长度", c)

	// slice
	letters := []string{"a", "b", "c", "d"}
	fmt.Println("slice", letters)

	for i, letter := range letters {
		fmt.Println(i, letter)
	}
}
