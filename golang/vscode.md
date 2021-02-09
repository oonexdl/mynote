# vscode

## 配置

(防火墙你懂的)

```sh
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```
vscode settings

```json
{
    "go.toolsEnvVars": {
        "HTTPS_PROXY": "https.proxy.address",
        "HTTP_PROXY": "https.proxy.address"
    }
}
```

## troubleshooting

https://github.com/golang/vscode-go/blob/master/docs/troubleshooting.md

https://github.com/golang/tools/blob/master/gopls/doc/troubleshooting.md
