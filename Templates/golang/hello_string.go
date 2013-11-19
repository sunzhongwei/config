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
	// 单行字符串
	name := "zhongwei"
	fmt.Println("name:", name)

	// 多行字符串
	multi_line := `Hello
i'm zhongwei`
	fmt.Println("text:", multi_line)

	// 切片操作
	fmt.Println("slice:", name[2:])

	// 连接字符串
	msg := " is good"
	new_msg := name + msg
	fmt.Println("new msg:", new_msg)

	// format string
	// func Sprintf(format string, a ...interface{}) string
	// Sprintf formats according to a format specifier and returns the resulting string.
	new_string := fmt.Sprintf("my name is: %v, age is: %v", name, 18)
	fmt.Println(new_string)

	// 不可修改
	// name[2] = 'c'
	// 上面一行在编译时，会报错 cannot assign to name[2]

	// 但是可以重新赋值
	name = name + " sun"
	fmt.Println("my full name is:", name)

	// 对字符串中的字符进行修改
	// # string -> []byte
	// # 对 []byte 中的字符进行修改
	// # []byte -> string
	tmp := []byte(name)
	tmp[0] = 'c'
	name = string(tmp)
	fmt.Println("new name:", name)
}
