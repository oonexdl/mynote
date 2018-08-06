目录
=================

+ [Let’s Encrypt 简介](#简介)
+ [获取证书](#获取证书)
+ [更新证书](#更新证书)
+ [修改 webserver 配置](#修改配置)
+ [Let's Encrypt 如何实现](#如何实现)

# 简介

需要知道的点

- 网站若需要启用 https，则必须获取证书授权机构(CA)颁发的证书
- Let’s Encrypt 是一个 CA，免费的
- Let’s Encrypt 使用 [ACME](https://ietf-wg-acme.github.io/acme/draft-ietf-acme-acme.txt) 协议确保你拥有域名的控制权

# 获取证书

```
mkdir $HOME/letsencrypt

docker run -it \
    -v $HOME/letsencrypt:/etc/letsencrypt \
    certbot/certbot certonly \
    --standalone \
    -d www.xiaodongli.me -d xiaodongli.me -d api.xiaodongli.me
```

# 更新证书

```
docker run -it \
    -v $HOME/letsencrypt:/etc/letsencrypt \
    certbot/certbot renew \
    --dry-run
```

# 修改配置

nginx:

```nginx
server {
    listen       443 ssl; 
    server_name  xiaodongli.me www.xiaodongli.me;

    ssl_certificate /etc/letsencrypt/live/www.xiaodongli.me/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/www.xiaodongli.me/privkey.pem;
}
```

# 如何实现

TODO: https://letsencrypt.org/how-it-works/