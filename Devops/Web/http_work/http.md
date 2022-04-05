# HTTP简介


## 1 什么是http

> HTTP(*Hypertext Transfer Protocol*) 主要是用来传输HTML的应用层协议。HTTP是无状态协议，表示不会保存任何状态信息在两次请求之间。HTTP是client-server协议。

![](resource/http01.png)

## 2 如何工作

![](resource/http02.png)

### golang写一个简单的web服务器


```golang
package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"
)


func sayHelloname(w http.ResponseWriter, r *http.Request){
	r.ParseForm()
	fmt.Println(r.Form)
	fmt.Println("path:", r.URL.Path)
	fmt.Println("scheme:", r.URL.Scheme)
	fmt.Println(r.Form["url_long"])
	for k, v := range r.Form {
		fmt.Println("key:", k)
		fmt.Println("val:", strings.Join(v, ""))
	}
	fmt.Fprintf(w, "Hello astaxie!")
}

func main(){
	http.HandleFunc("/", sayHelloname)
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
```

## 3 阅读材料

[WebSocket](https://zh.wikipedia.org/wiki/WebSocket)


## reference

[http阅读资料](https://developer.mozilla.org/en-US/docs/Web/HTTP)

[nginx-wiki](https://zh.wikipedia.org/wiki/Nginx)

[http-wiki](https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)


---

[---Back---](../README.md)
