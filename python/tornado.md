# tornado

包含异步网络库的web框架

## gen.coroutine vs run_in_executor

如果修饰的 func 的内部调用支持异步IO，直接用 gen.coroutine。如果是阻塞IO，需要 run_in_executor，以便实现异步调用。类似 js 的 promisefy?
