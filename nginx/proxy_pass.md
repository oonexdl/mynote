## proxy_pass 指令

来源: http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass

```nginx
    # 请求的 uri 会被 proxy_pass 声明的 uri 覆盖
    location /name/ {
        proxy_pass http://127.0.0.1/remote/;
    }

    # 请求的 uri 会被附加到 proxy_pass 后
    location /some/path/ {
        proxy_pass http://127.0.0.1;
    }
```