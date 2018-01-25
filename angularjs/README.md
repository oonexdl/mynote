### html compiler

1. $compile 遍历（广度搜索?）整个 DOM，将匹配到的 directives 跟相应的 DOM element 关联起来，类似 [ element => [directives]]，
然后根据每个 directive 的 priority 进行排序

2. 当任意一个节点完成上一步后，顺序执行每个 directive 的 compile 方法（用来操作 DOM element），每个 compile 返回的 link 函数会被 merge 成 combined link 函数

3. 获取当前节点的 scope，连接 template

  - scope 作为参数执行上一步得到的 combiled link (可以依据 scope 对象来操作 DOM element)函数
  - 注册 DOM element listeners
  - 为 scope 设置 $watches

4. 当前节点重复以上步骤

### this vs $scope

- $scope 下的变量有继承关系，即 child scope 可以取到 parent scope 中的变量，child scope 下的同名变量不会影响 parent scope
- this 下的变量无继承关系，this 也属于 $scope 的一个可读属性，可以使用 ng-model="this.variable" 进行跨 scope 的双向绑定

栗子:
```js
var parentController = function($scope) {
  this.selectAll = true;
  $scope.selectAll = true;
  return this;
};

var childController = function($scope) {
  // empty
}
```

```html
<div ng-controller="parentController as parent">  
  <input type="checkbox" ng-model="parent.selectAll"></input>
  <input type="checkbox" ng-model="selectAll"></input>
  <div ng-controller="childController">
    <!-- parent sync to child  -->
    <input type="checkbox" ng-model="parent.selectAll"></input>
    
    <!-- parent will be changed when input checked -->
    <input type="checkbox" ng-model="selectAll"></input>
  </div>
</div>
```
