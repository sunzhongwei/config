// > go run hello.go
// or
// > go build hello.go
// > ./hello

package main

import "fmt"
import "time"

func Task(taskId int) {
	for i := 0; i < 10; i++ {
		fmt.Println("task id:", taskId, ":", i, "Sleep 3 seconds...")
		time.Sleep(3 * time.Second)
	}
}

func main() {
	fmt.Println("Start ...")
	// 需要注意的是，如果 main 执行完，Task 中的逻辑即使没有跑完，也会被退出
	go Task(0)
	var input string
	fmt.Println("Please input:")
	fmt.Scanln(&input)
	fmt.Println("Your input is: ", input)
}
