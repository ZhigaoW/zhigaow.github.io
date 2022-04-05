package main

import (
	"context"
	"fmt"
)

/*

func main() {
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		time.Sleep(2 * time.Second)
		fmt.Println("Task 1 Done")
		wg.Done()
	}()
	go func() {
		time.Sleep(1 * time.Second)
		fmt.Println("Task 2 Done")
		wg.Done()
	}()
	wg.Wait()
	fmt.Println("OK, All Task Have Done")
}

*/

/*

func main() {
	stop := make(chan bool)
	go func() {
		for {
			select {
			case <-stop:
				fmt.Println("监控退出，停止了...")
				// 函数return
				return
			default:
				fmt.Println("goroutine监控中...")
				time.Sleep(2 * time.Second)
			}
		}
	}()

	time.Sleep(20 * time.Second)
	fmt.Println("通知监控停止")
	stop <- true
	// 检查监控还有没有输出
	time.Sleep(5 * time.Second)
}

*/

/*

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	go func(ctx context.Context) {
		for {
			select {
			case <-ctx.Done():
				fmt.Println("监控退出，停止了")
				return
			default:
				fmt.Println("goroutine监控中...")
				time.Sleep(2 * time.Second)
			}
		}
	}(ctx)

	time.Sleep(10 * time.Second)
	fmt.Println("可以了，通知监控停止")
	cancel()
	// 监控goroutine是否停止
	time.Sleep(5 * time.Second)
}
*/

/*

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	go watch(ctx, "[监控1]")
	go watch(ctx, "[监控2]")
	go watch(ctx, "[监控3]")
	go watch(ctx, "[监控4]")

	time.Sleep(10 * time.Second)
	fmt.Println("可以了，通知监控停止")
	cancel()

	time.Sleep(5 * time.Second)

}

func watch(ctx context.Context, name string) {
	for {
		select {
		case <-ctx.Done():
			fmt.Println(name, "监控退出了,停止了...")
			return
		default:
			fmt.Println(name, "goroutine监控中")
			time.Sleep(2 * time.Second)
		}
	}
}

*/

/*

var key string = "name"

func main() {
	ctx, cancel := context.WithCancel(context.Background())

	valueCtx := context.WithValue(ctx, key, "【监控1】")

	go watch(valueCtx)

	time.Sleep(10 * time.Second)
	fmt.Println("可以了，通知监控停止")

	cancel()

	time.Sleep(5 * time.Second)

}

func watch(ctx context.Context) {
	for {
		select {
		case <-ctx.Done():
			fmt.Println(ctx.Value(key), "监控退出了,停止了...")
			return
		default:
			fmt.Println(ctx.Value(key), "goroutine监控中")
			time.Sleep(2 * time.Second)
		}
	}
}

*/

// chan <-
func ping(pings chan<- string, msg string) {
	pings <- msg
}

// <-chan
// chan<-

func pong(pings <-chan string, pongs chan<- string) {
	// msg := <-pings
	// pongs <- msg
}

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	pings := make(chan string, 1)
	pongs := make(chan string, 1)
	ping(pings, "passed message")
	pong(pings, pongs)
	fmt.Println(<-pongs)
}
