### Event Loop and None-blocking I/O

First, see the following example:

```js
var start = Date.now();
var event1 = function() {
    setTimeout(function () {
        var event1Time = Date.now();
        console.info('event1 executed after ' + (event1Time - start));  
    }, 1000);
};

var event2 = function() {
    setTimeout(function () {
        var event2Time = Date.now();
        console.info('event2 executed after ' + (event2Time - start)); 
    }, 500);
};

event1();
event2();

var now  = Date.now();
while (now - start <= 5000) {
    now = Date.now();
}

// output
// event2 executed after 5001                                                                  
// event1 executed after 5010 
``` 
As we all know that js executes in single-thread, so who is responsible for managing the timer callback?

In fact, participators consist of main execution thread, events queue, watcher and I/O thread pool.

#### Event Queue

In browser, event means that user interact with GUI, network activity, timer.
In os, event mostly come from `I/O`.

Event queues are here for storing these events.

#### Watcher 

The Watcher is responsible for gathering events from os, and sent callback for main thread.
In linux, watcher is implement by [libuv](https://nikhilm.github.io/uvbook/basics.html]) 

In above example, event is timer. when timer is expired, it's put to events queue.
Then corresponding callback is executed in next event loop. 

See the event loop pseudocode:

```js
while(true) {
    event = getEvents();
    if !events
        continue;

    for event in events
        if !event.work.isExpired
            continue;
        sendToJsThread(event.work);
}
```

#### I/O thread pool

In fact, none-blocking `I/O` is implemented by thread pool.

When main thread request an asynchronous operation, like read file from disk.
The operation is distributed to one of thread pool, then main thread return.
But now the execution thread for `I/O` is **blocked**, waiting for kernel read file finished.
After the operation finished, **watcher** gathers the corresponding event for event loop.
Finally, the main thread executed the callback.
