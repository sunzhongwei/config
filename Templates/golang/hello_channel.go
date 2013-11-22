// > go run hello.go
// or
// > go build hello.go
// > ./hello

package main

import (
	"fmt"
	"time"
)

func sender(c chan string) {
	for {
		// 发送和接收是阻塞的，只有当发送方和接受方都准备好的时候，才会执行
		// 也就是会加锁. 消息并不会被覆盖。
		c <- "Hello world!"
		c <- "Waga Waga!"
		c <- "3"
		time.Sleep(1 * time.Second)
	}
}

func sender2(c chan string) {
	for {
		c <- "Waga Waga!"
		time.Sleep(1 * time.Second)
	}
}

func receiver(c chan string) {
	for {
		msg := <-c
		fmt.Println("received:", msg)
		time.Sleep(1 * time.Second)
	}
}

func main() {
	fmt.Println("Start ...")
	c := make(chan string)
	go sender(c)
	//go sender2(c)
	go receiver(c)

	var input string
	fmt.Scanln(&input)
}
