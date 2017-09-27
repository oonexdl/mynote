### html compiler

*源码读到精神崩溃，脑补一下 angularjs html 的编译过程*

1. $compile 遍历（广度搜索?）整个 DOM，将匹配到的 directives 跟相应的 DOM element 关联起来，类似 [ element => [directives]]，
然后根据每个 directive 的 priority 进行排序

2. 当任意一个节点完成上一步后，顺序执行每个 directive 的 compile 方法（用来操作 DOM element），每个 compile 返回的 link 函数会被 merge 成 combined link 函数

3. 获取当前节点的 scope，连接 template

  - scope 作为参数执行上一步得到的 combiled link (可以依据 scope 对象来操作 DOM element)函数
  - 注册 DOM element listeners
  - 为 scope 设置 $watches

4. 当前节点重复以上步骤

