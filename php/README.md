目录
=================

+ [php 中的生成器](#generator)
+ [yii2 behaviors 如何实现对 component 属性，方法的注入](#yii2-behaviors)
+ [yii2 的错误处理](#yii2-handler)

# generator

send 有何作用?

```php
function gen() {
    $a = yield '1';
    echo "$a\n";
    $b = yield '2';
}

$gen = gen();
// 当前 yield 值是 '1'
echo ($gen->current() . "\n");

// 将当前 yield 值设置为 '1.5'，紧接着复制给 $a，继续执行至下一个 yield
$gen->send('1.5');

// 当前 yield 值为 '2'
echo ($gen->current() . "\n");
```

输出:

1
1.5
2

# yii2-behaviors

Yii2 ActionFilter 继承自 behavior

官方注解: 

** * An action filter will participate in the action execution workflow by responding to
 * the `beforeAction` and `afterAction` events triggered by modules and controllers.**

即向 action 执行前后的 event 中注册回调函数

- 成员函数的注入

1. 获取类中未声明的方法时，调用 **__call()**
2. 遍历已绑定的 behavior 数组，尝试获取 behavior 中的同名 public 方法

```php
public function __call($name, $params)
{
    $this->ensureBehaviors();
    foreach ($this->_behaviors as $object) {
        if ($object->hasMethod($name)) {
            return call_user_func_array([$object, $name], $params);
        }
    }
}
```

- 属性的注入

1. 获取类中未声明的属性时，调用 **__get()**
2. 拼接 getter 函数，尝试调用
3. 遍历已绑定的 behavior 数组，尝试获取 behavior 中的同名 public 属性

```php
public function __get($name)
{
    $getter = 'get' . $name;
    if (method_exists($this, $getter)) {
        // read property, e.g. getName()
        return $this->$getter();
    } else {
        // behavior property
        $this->ensureBehaviors();
        foreach ($this->_behaviors as $behavior) {
            if ($behavior->canGetProperty($name)) {
                return $behavior->$name;
            }
        }
    }
}
```

# yii2-handler

## ErrorHandler
将 warning, notice 等 php 的提示转化为可捕获的 Exception，并根据 Excetion 的类型进行相应的处理，比如进行日志记录(logException)，拦截并修改 response (renderExcetion)

## Log
 使用 \yii\log\Dispatch 类对 yii::warning 等方法输出的消息进收集，并发送到配置的 LogTargets 指定的日志位置，可以是 db, email, file, stdout 等，具体只需要对 \yii\log\Target::export 进行重写

参数 **flushInterval** , **exportInterval** 分别控制输出到 Target 的消息大小阈值和 Target 输出消息到指定位置的阈值

## ErrorHandler 的注册流程

```php
class ErrorHandler
{
    public function register()
    {
        // http://php.net/manual/zh/errorfunc.configuration.php#ini.display-errors
        // 关闭默认错误信息输出
        ini_set('display_errors', false);
        // 处理代码抛出的 exception
        set_exception_handler([$this, 'handleException']);
        // 处理代码级别的 error，并转换为 excetion
        set_error_handler([$this, 'handleError']);
       // memoryReserveSize 表示预分配的内存，用来处理内存溢出产生的错误
        if ($this->memoryReserveSize > 0) {
            $this->_memoryReserve = str_repeat('x', $this->memoryReserveSize);
        }
        //
        register_shutdown_function([$this, 'handleFatalError']);
    }

    public function handleException($exception)
    {
        if ($exception instanceof ExitException) {
            return;
        }

        $this->exception = $exception;

        // disable error capturing to avoid recursive errors while handling exceptions
        restore_error_handler();
        restore_exception_handler();
        try {
            // 写入到错误日志中
            $this->logException($exception);
            if ($this->discardExistingOutput) {
                $this->clearOutput();
            }
            // 渲染终端用户看到的异常显示
            $this->renderException($exception);
            if (!YII_ENV_TEST) {
                exit(1);
            }
        } catch (\Exception $e) {
            // an other exception could be thrown while displaying the exception
            $msg = (string) $e;
            $msg .= "\nPrevious exception:\n";
            $msg .= (string) $exception;
            if (YII_DEBUG) {
                if (PHP_SAPI === 'cli') {
                    echo $msg . "\n";
                } else {
                    echo '<pre>' . htmlspecialchars($msg, ENT_QUOTES, Yii::$app->charset) . '</pre>';
                }
            }
            $msg .= "\n\$_SERVER = " . VarDumper::export($_SERVER);
            error_log($msg);
            exit(1);
        }

        $this->exception = null;
    }
}
```