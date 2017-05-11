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
As we all know that js executes in single-thread, so how the example works ?

In fact, event driven consist of main execution thread, observer and I/O thread pool.

Observer is a role who checks whether there is pending works and send work to js thread for executation.

The thread selected from pool executes blocking I/O operation until it finished, and then send rest work(like callback) to observers.

See the pseudocode:

```js
while(true) {
    works = getWorks();
    if !works
        continue;

    for work in works
        if !work.isExpired
            continue;
        sendToJsThread(work);
}
```
See the above example again, `setTimeout` can be regarded as asynchronous `I/O`. When `I/O` finished, send works to corresponding observer.
Observer send the work which is expired(after 1000, 500 and so on) to js execution thread.

Js always executes in a single-thread, so the two asynchronous works executed after `while` function finished in 5000 ms.
