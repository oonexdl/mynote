## try_files

按照声明的参数依次检查文件是否存在(filePath = root + request_uri + index)，若均不存在，内部跳转到最后一个参数

例子:

```nginx
server {
    listen 7000;

    root /app;

    index index.html;

    location / {
        try_files $uri $uri/ /default.html;
    }
}
```
```
＃ 目录文件
- index.htm
- default.htm
- dir
  - dir.html
- dirIndex
  - index.html
```

- `/`
  * 解析 $uri: /app + / + index.html, 文件存在立即返回 `/app/index.html`
- `/dir`
  * 解析 $uri: /app + /dir，文件不存在
  * 解析 $uri/: /app + /dir，目录存在，nginx 尝试 index 返回 `/app/dir/index.html`，文件不存在返回 403
- `/dir/dir.html`
  * 解析 $url: /app + /dir/dir.html，文件存在立即返回
- `/dirIndex`
  * 解析 $uri: /app + /dirIndex，文件不存在
  * 解析 $uri/: /app + /dirIndex，目录存在，nginx 尝试 index 返回 `/app/dirIndex/index.html`，文件存在立即返回
- `/dirIndex/dir.html`
  * 解析 $uri: /app + /dirIndex/dir.html，文件不存咋
  * 解析 $uri/，目录不存在，内部跳转(寻找下一个location块) 到 /default.htm
  * 匹配到 / location
  * 解析 $uri: /app + /default.htm，文件存在立即返回
