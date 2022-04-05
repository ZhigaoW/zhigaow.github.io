
1. Context设计为一个interface

```golang
type Context interface {
    Deadline() (deadline time.Time, ok bool)
    Done() <-chan struct{}
    Err() error
    value(key interface{}) interface{}
}
```

2. context包中最常用的方法是

```golang

func Background() Context {
	return background
}

func TODO() Context {
	return todo
}

```











