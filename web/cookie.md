# Cookie

## request header syntax

```
# 请求的服务地址，通常是一个域名
host: api.github.com
# 发起请求的网站地址，包含协议
origin: https:#sss.mozilla.org
# 发起请求的网站完整url
referer: https:#sss.mozilla.org/test.html
```

## response cookie syntax

```
Set-Cookie: <cookie-name>=<cookie-value>
  
# 过期时间
Set-Cookie: <cookie-name>=<cookie-value>; Expires=<date>
  
# 最大存活时间，如果同时设置了 Expires，优先使用 Max-Age
Set-Cookie: <cookie-name>=<cookie-value>; Max-Age=<non-zero-digit>
  
# 只能通过 https 协议传输
Set-Cookie: <cookie-name>=<cookie-value>; Secure

# 如果设置，则 cookie 不能被客户端 Javascript 代码获取到(ducument.Cookie无法访问)
Set-Cookie: <cookie-name>=<cookie-value>; HttpOnly

# 匹配域名
# 限定可以接收客户端 cookie 的服务器域名
# 如果设置为特定域名，则子域名也包含在内。例如设置 Domain=github.com，则请求二级域名 api.github.com 也会带上 cookie
# 如果未设置，默认使用请求时的 host，并且不包含子域名
Set-Cookie: <cookie-name>=<cookie-value>; Domain=<domain-value>
  
# 匹配 URL 路径
# 请求的 URL 路径必须包含 Path，否则不发送 cookie
Set-Cookie: <cookie-name>=<cookie-value>; Path=<path-value>

# 同源策略，用于防止(CSRF)，默认为 Lax
# 当设置为 Strict，则 cookie 仅发送给与当前网站地址同源的服务器地址(强制要求请求域名与网站域名一致)
# 例如在 a.com 网站下请求 b.com 的授权接口，b.com 返回 cookie(Domain=b.com; SameSite=Strict)。当 a.com 再次发送请求到 b.com，不会带上 b.com 的 cookie
Set-Cookie: <cookie-name>=<cookie-value>; SameSite=Strict
# Lax 与 Strict 类似，但有一点例外：在 a.com 网站上点击带有 b.com 的跳转链接时，依然会发送 b.com 返回的 cookie
Set-Cookie: <cookie-name>=<cookie-value>; SameSite=Lax
# 设置为 None 则不检查是否同源，但必须在 https 协议下传输
Set-Cookie: <cookie-name>=<cookie-value>; SameSite=None; Secure

# 多属性设置
Set-Cookie: <cookie-name>=<cookie-value>; Domain=<domain-value>; Secure; HttpOnly
```

## invalid domains
  
两种无效 cookie domain 设置方式:

1. domain 不包含 request host。比如服务端 originalcompany.com 设置了 cookie Domain=somecompany.co.uk
2. domian 设置为 request host 的子域名。比如服务端 example.com 设置了 cookie Domain=foo.example.com
  
## reference
  
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie
