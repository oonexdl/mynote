# 安装

https://openresty.org/en/linux-packages.html

# 快速开始

https://openresty.org/en/getting-started.html

https://github.com/openresty/lua-nginx-module

## ngx.location.capture 的使用

转发 POST 请求时，如果不在之前开启 lua_need_request_body 或调用 ngx.req.read_body()，请求会一直阻塞(block)

```
    location /echo_body {
        lua_need_request_body on;
        content_by_lua '
            local res = ngx.location.capture(
                "/proxy",
                { method = ngx.HTTP_POST, always_forward_body = true)

            ngx.print(res.body)
        ';
    }
```
