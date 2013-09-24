// > go run hello.go 
// or 
// > go build hello.go
// > ./hello

package main

import (
	"fmt"
	"io/ioutil"
)

type Page struct (
    Title string
    Body []byte
)

func (p *Page) save() error {
	filename := p.Title + ".txt"
    return ioutil.WriteFile(filename, p.Body, 0600)
}

func main() {
    fmt.Println("Hello world")
}

