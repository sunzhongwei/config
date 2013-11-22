// > go run hello.go
// or
// > go build hello.go
// > ./hello

package main

import "fmt"
import "time"

func Task(taskId int) {
	for i := 0; i < 100000000; i++ {
		time.Sleep(1 * time.Second)
		fmt.Println("task id:", taskId, ":", i)
	}
}

func main() {
	fmt.Println("start ...")
	for i := 0; i < 4; i++ {
		// 很明显这个地方就将多核利用起来了，soga
		go Task(i)
	}

	// in case main exit
	var input string
	fmt.Scanln(&input)
}
