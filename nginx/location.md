## location 模块的匹配原则

来源 http://nginx.org/en/docs/http/ngx_http_core_module.html#location

### 流程

1. 首先 decode request uri，解析相对路径，去除多余的 "/" 
2. 匹配前缀字符串
  * 找到精确字符串(= 前缀),终止匹配
  * 找到最长的字符串，若包含前缀 "^~"，终止后续正则表达式匹配
3. 按照配置块的顺序，匹配正则表达式，找到第一个后，终止匹配
4. 若第 3 步未匹配到，则使用第 2 步选择的配置块

### 栗子

```nginx
    # 精确匹配，匹配后会终止搜索
    location = / {
        [ configuration A ]
    }

    # 普通前缀匹配
    location / {
        [ configuration B ]
    }

    # 普通前缀匹配
    location /documents/ {
        [ configuration C ]
    }

    # 前缀匹配，匹配后会终止正则表达式搜索
    location ^~ /images/ {
        [ configuration D ]
    }

　　 # 大小写敏感的正则表达式 
    location ~* \.(gif|jpg|jpeg)$ {
        [ configuration E ]

        @anotherlocation;
    }

    location @anotherlocation {
        [ configuration F ]
    }
```

- "/" 匹配 A
- "/index.html" 匹配 B
- "/documents/document.html" 匹配 C
- "/images/1.gif" 匹配 D
- "/documents/1.jpg" 匹配 F