/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com

测试常量的使用。
*/

package main

import (
	"fmt"
)

// 常量的定义： 类型可以不明确指明
const OK = 0
const ERR int = 1

func main() {
	fmt.Println("Hello world")
	fmt.Println("OK:", OK)
	fmt.Println("ERR:", ERR)
}
