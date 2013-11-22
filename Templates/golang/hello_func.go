/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com
*/

package main

import (
	"errors"
	"fmt"
	"os"
)

// normal
func sayHello() {
	fmt.Println("Hello world!")
}

// multi return value
// ignore return value name
func getMsg(name string, age int) (int, string) {
	ret_code := 0
	msg := fmt.Sprintf("name is: %v, age is: %v", name, age)
	return ret_code, msg
}

// multi return value
// For public function, it's better adding return value name to document well.
func GetMsg(name string, age int) (msg string, err error) {
	if age > 18 {
		err = errors.New("Sorry, you are too old.")
		msg = ""
	} else {
		err = nil
		msg = fmt.Sprintf("name is: %v, age is: %v", name, age)
	}

	return
}

// 不定数量的参数
func GetMembers(names ...string) {
	fmt.Println("Member list:")
	for _, name := range names {
		fmt.Println(name)
	}
}

// 传值
// 实际上是传了这个值的一份 copy
func modifyCopy(age int) int {
	age += 1
	return age
}

// 传指针
// 传递变量在内存中的地址
// 传指针的应用场景：
// 1. 多个函数操作同一个对象
// 2. 传指针性能好。传指针比较轻量级 8 bytes, 只是传递内存地址，我们可以用指针
// 传递体积大的结构体。如果用参数值传递的话，在每次 copy 上面就会花费相对较多
// 的系统开销(内存和时间)
func modifyRealValue(age *int) int {
	*age += 1
	return *age
}

// string, slice, map 这三种类型的实现机制类似指针
// 所以可以直接传递，而不用取地址后传递指针。
// 注意，若函数需要改变 slice 的长度，则仍需要取地址传递指针.
// 下面的例子，没有改变 slice 的长度, 所以不需要取地址。
func modifySlice(members []string, newMember string) {
	members[1] = newMember
}

// defer
func deferCloseFile() (err error) {
	err = nil

	file, err := os.Open("hello_var.go")
	if err != nil {
		err = errors.New("Fail to open file")
		return
	}
	defer file.Close()

	data := make([]byte, 100)
	count, err := file.Read(data)
	if err != nil {
		err = errors.New("Fail to read file")
		return
	}
	fmt.Printf("Read %d bytes: %q\n", count, data[:count])

	return // must add this line, or "missing return at end of function"
}

// defer
func deferCloseFile2() (err error) {
	err = nil

	file, err := os.Open("not_exist.file")
	if err != nil {
		err = errors.New("Fail to open file")
		return
	}
	defer file.Close()

	data := make([]byte, 100)
	count, err := file.Read(data)
	if err != nil {
		err = errors.New("Fail to read file")
		return
	}
	fmt.Printf("Read %d bytes: %q\n", count, data[:count])

	return
}

// panic and recover
func readFile() {
	defer func() {
		if x := recover(); x != nil {
			fmt.Println("err happens")
			fmt.Println(x)
		}
	}() // not lost () at the end

	file, err := os.Open("not_exist.file")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	data := make([]byte, 100)
	count, err := file.Read(data)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Read %d bytes: %q\n", count, data[:count])
}

// init
// run before main
func init() {
	fmt.Println("init")

	user := os.Getenv("USER")
	if user == "" {
		panic("no value for $USER")
	}
	fmt.Printf("value of $USER is %v\n", user)
}

func main() {
	sayHello()

	ret_code, msg := getMsg("zhongwei", 18)
	fmt.Printf("ret_code is: %v, msg is: '%v'\n", ret_code, msg)

	ages := []int{17, 20}
	for _, age := range ages {
		msg, err := GetMsg("zhongwei", age)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Printf("msg is: '%v'\n", msg)
		}
	}

	GetMembers("Zhongwei", "Ubuntu", "Mac")

	age := 18
	fmt.Println("age is", age)
	new_age := modifyCopy(age)
	fmt.Println("new age is", new_age)
	fmt.Println("age is", age)

	age2 := 18
	fmt.Println("age is", age2)
	new_age2 := modifyRealValue(&age2)
	fmt.Println("new age is", new_age2)
	fmt.Println("age is", age2)

	members := []string{"zhongwei", "ubuntu"}
	modifySlice(members, "mac")
	fmt.Println(members)

	err := deferCloseFile()
	if err != nil {
		fmt.Println(err)
	}
	err = deferCloseFile2()
	if err != nil {
		fmt.Println(err)
	}

	readFile()

}
