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
        c <- "Hello world!"
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
        msg := <- c
        fmt.Println(msg)
        time.Sleep(1 * time.Second)
    }
}


func main() {
    fmt.Println("Start ...")
    c := make(chan string)
    go sender(c)
    go sender2(c)
    go receiver(c)
    
    var input string
    fmt.Scanln(&input)
}

