# 如何实现平滑关闭?

先假设一种常见的任务模式: 

主协程阻塞，任务通过 for 循环跑在子协程中。当进程收到退出信号(ctrl-c)，程序直接退出，任务协程没有机会正常结束正在执行的任务(sleep 未结束直接阵亡...)

```go
func main() {
  s := make(chan bool, 1)
  go func() {
    for {
      // 模拟任务执行
      time.Sleep(5*time.Duration)
    }
  }()
  
  // 一直阻塞
  <-s
}
```

要做到任务协程可靠退出，容易想到的一个方案就是主协程监听 signal，收到 int(term) 信号后传递给任务协程，任务协程收到后先处理完当前任务，再回传信号到主协程。

核心思想就是要保证下面两点:

1. 主协程收到终止信号后应当继续阻塞
2. 子协程处理完任务后应当回传信号

```go
func main() {
  // 监听退出信号
  mSig := make(chan os.Signal ,1)
  // 如不确定信号，可以使用 signal.Notify(mSig) 监听所有信号
  signal.Notify(mSig, os.Interrupt)
  // 用于传递信号
  cSig := make(chan os.Signal, 1)
  // 用于回传信号
  notifySig := make(chan os.Signal, 1)
  go func() {
    for {
      select {
        case s := <-cSig:
          notifySig <- s
          return
        default:
          time.Sleep(5*time.Duration)
      }
    }
  }()
  
  for {
    select {
      case s := <-mSig:
        cSig <- s
      case <-notifySig:
        // 子协程已退出
        return
    }
  }
}
```
