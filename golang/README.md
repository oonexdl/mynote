目录
=================

+ [why go?](#历史)

# 历史

为了解决在21世纪多核和网络化环境下越来越复杂的编程问题, Ken Thompson(UNIX操作系统、B语言作者) 和 Rob Pike 以及 Robert Griesemer(设计了 v8 引擎和 HotSpot 虚拟机)合作发明了 go 语言。

go 的基础语法源自于 c，模块导入概念 Oberon，goroutine 的概念则借鉴于 Alef。


# 接口与类型系统

```go
type MyInt int

var i int
var j MyInt
```

每个变量都有确定的静态类型

i 和 j 有相同的底层类型，但在 go 的静态类型系统里，仍是不同的类型，无法相互赋值

```go
// Reader is the interface that wraps the basic Read method.
type Reader interface {
    Read(p []byte) (n int, err error)
}

// Writer is the interface that wraps the basic Write method.
type Writer interface {
    Write(p []byte) (n int, err error)
}

var r io.Reader
r = os.Stdin
r = bufio.NewReader(r)
r = new(bytes.Buffer)
```

接口类型是一种特殊的静态类型，代表了一系列方法的集合

接口类型的变量 r 可以存储任意具体类型(非接口类型)，前提该具体类型实现了接口声明的方法集合

不论 r 包含了何种具体类型，它的静态类型仍然是 io.Reader(也就是说，变量的类型是无法改变的，这就是静态类型语言的特点)

```go
interface{}
```

空接口没有声明方法，因此可以存储任何类型


```go
var r io.Reader
tty, err := os.OpenFile("/dev/tty", os.O_RDWR, 0)
if err != nil {
    return nil, err
}
r = tty
```

























---------

参考文档:

+ [go语言圣经](https://yar999.gitbooks.io/gopl-zh/content/)
+ [go语言高级编程](https://github.com/chai2010/advanced-go-programming-book)
+ [go官方博客](https://blog.golang.org)
