/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com
*/

package main

import (
	"fmt"
)

type Person struct {
	name string
	age  int
}

// 继承
type Coder struct {
	Person    // 匿名字段
	languages []string
}

// object method
func (person Person) sayHi() {
	fmt.Printf("Hi, i'm %v, %v old\n", person.name, person.age)
}

func (coder Coder) sayHello() {
	fmt.Println("Hello world!")
}

// pointer or copy
// 使用指针才能修改属性值, 否则修改的只是 copy 的数值
// 可以把 receiver 当作 method 的第一次参数来看
func (person *Person) getOlder() {
	person.age += 1
}

func (person Person) getOlder2() {
	person.age += 1
}

// interface
// 凡是实现了 sayHi, sayHello 的对象都是 BestCoder
type BestCoder interface {
	sayHi()
	sayHello()
}

// empty interface: interface {}
// 由于 empty interface 没有定义任何 method，所以任何类型都满足 empty
// interface 的要求。类似与 c 语言的 void *.
// 所以，如果一个函数把 interface{} 作为参数，说明其可以接受任何类型的参数，
// 返回值类型同样的道理
type something interface{}

var i something = 1

func main() {
	fmt.Println("Hello world")

	// 顺序初始化
	coder := Coder{Person{"zhongwei", 18}, []string{"Python", "Go"}}
	fmt.Printf("coder: %+v\n", coder)

	// k: v 初始化
	coder2 := Coder{
		Person:    Person{name: "zhongwei", age: 18},
		languages: []string{"Python", "Go"},
	}
	fmt.Printf("coder2: name: %v, age: %v, languages: %v\n",
		coder2.name, coder2.age, coder2.languages)

	coder.sayHi()
	coder.sayHello()

	coder.getOlder2()
	fmt.Printf("age: %v\n", coder.age)

	coder.getOlder()
	fmt.Printf("age: %v\n", coder.age)

	bestCoders := []BestCoder{coder, coder2}
	for _, p := range bestCoders {
		p.sayHi()
		p.sayHello()
	}

	// judge type of element
	for _, p := range bestCoders {
		switch value := p.(type) {
		case Coder:
			fmt.Println("i'm a coder")
			fmt.Println(value)
		default:
			fmt.Println("nothing")
		}

	}
}
