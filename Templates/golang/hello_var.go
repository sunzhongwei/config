/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com

测试 golang 中定义变量的三种方式。
*/

package main

import (
	"fmt"
)

// 注意：全局变量只能使用正常式，和省去类型式样, 不能使用极简式
var URL = "http://sunzhongwei.com"
var URL2 string = "http://www.sunzhongwei.com"

func main() {
	// 正常式
	var name string = "zhongwei"
	var name1, name2 string = "hello", "world"
	fmt.Printf("name: %v\n", name)
	fmt.Printf("name1: %v, name2: %v\n", name1, name2)

	// 省去类型
	var table = "user"
	var table1, table2 = "user1", "user2"
	fmt.Printf("table: %v\n", table)
	fmt.Printf("table1: %v, table2: %v\n", table1, table2)

	// 同时省去类型和 var
	score := 100
	score1, score2 := 200, 300
	fmt.Println(score)
	fmt.Println(score1, score2)

	fmt.Println("url:", URL)
	fmt.Println("url2:", URL2)
}
