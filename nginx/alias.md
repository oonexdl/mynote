## alias

来源: http://nginx.org/en/docs/http/ngx_http_core_module.html#alias

```nginx
location /i/ {
    alias /data/w3/images/;
}
```

请求 uri “/i/top.gif”, 文件 /data/w3/images/top.gif 将被发送.
