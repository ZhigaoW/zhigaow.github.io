

## 一个好的例子

```go
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	str, _ := reader.ReadString('\n')

	strsli := strings.Split(str, " ")
	strsli = strsli[:len(strsli)-1]

	nums := []int{}
	for _, s := range strsli {
		t, _ := strconv.Atoi(s)
		nums = append(nums, t)
	}

	fmt.Println(nums)

}
```




# fmt & bufio

[fmt](https://pkg.go.dev/fmt)

## fmt.Scan

`Scan`从标准输入读入文本，将连续的被空格分隔的值存储在连续的参数中。新行被计算为空格。返回成功扫描的值的数量，如果成功扫描的数量没有参数多，`err`将会显示原因。


```go
func Scan(a ...any) (n int, err error)
```


### 用法

```go
var (
    s string
    n int
    f float64
)

fmt.Scan(&s, &n, &f)
fmt.Println(s, n, f)
```

```bash
$ go run main.go 
hello 10
-56.2 
hello 10 -56.2
```


## fmt.Scanf


- 标准输入读入文本
- 将连续的被空格分隔的值存入连续的参数
- 存入的形式被`format`决定
- 错误会被`err`返回
- **新的一行必须和format中的换行符匹配**
  - The one exception: the verb %c always scans the next rune in the input, even if it is a space (or tab etc.) or newline.


```go
func Scanf(format string, a ...any) (n int, err error)
```

### 用法

```go
var n1, n2 int
fmt.Scanf("%d\n%d", &n1, &n2)
fmt.Println("n1 = ", n1, "n2 = ", n2)
```

```bash
$ go run main.go
12
15
n1 =  12 n2 =  15
```





## fmt.Scanln

`Scanln`和`Scan`很像，但是会在新一行停下来，同时最后一项之后必须是换行符或者文件结束符`EOF`

```go
func Scanln(a ...any) (n int, err error)
```

### 用法

```go
var (
    s string
    n int
    l float64
)
fmt.Scanln(&s, &n, &l)
fmt.Println(l, n, s)
```

```bash
$ go run main.go 
str -89 989.901
989.901 -89 str
```



## Reader

`Reader`是定义在bufio.go文件下的结构体

```go
func (b *Reader) ReadString(delim byte) (string, error)
```

`ReadString`会在遇到*delim*时候停止, **注意，其会将delim也读入**


### 用法

```go
reader := bufio.NewReader(os.Stdin)
str, _ := reader.ReadString('\n')
strSli := strings.Split(str, " ")

// 不加这一行会有换行符也被读入
strSli = strSli[:len(strSli)-1]
fmt.Println(strSli)
```



```bash
$ go run main.go 
aaa bbb ccc abc cba
[aaa bbb ccc abc]
```




















