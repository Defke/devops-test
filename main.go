package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.String(200, "aaaaaaccc")
	})
	fmt.Println("aadd")
	router.Run(":8089")
}
