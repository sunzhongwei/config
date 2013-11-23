/*
Copyright 2013 Zhongwei Inc.

Author: Zhongwei Sun
EMail:  zhongwei.sun2008@gmail.com
*/

package main

import (
	"fmt"
	"time"
)

func scanClient(signal chan string) {
	signal <- "start"
	time.Sleep(20 * time.Second)
	signal <- "stop"
}

func scanService(signal, progress chan string) {
	for {
		select {
		case s := <-signal:
			if s == "start" {
				// start scanning
				fmt.Println("Start scan")
				for i := 0; i < 30; i++ {
					progress <- fmt.Sprintf("%d / 30", i)
					time.Sleep(1 * time.Second)
				}
			} else {
				// stop scanning
				fmt.Println("End scan")
				return
			}
		}
	}
}

func readProgress(progress chan string) {
	for {
		select {
		case p := <-progress:
			fmt.Println("progress", p)
		}
	}
}

func main() {
	fmt.Println("Hello world")

	signal := make(chan string)
	progress := make(chan string)
	fmt.Println("signal init value:", signal)

	go scanClient(signal)
	go scanService(signal, progress)
	go readProgress(progress)

	var input string
	fmt.Scanln(&input)
}
