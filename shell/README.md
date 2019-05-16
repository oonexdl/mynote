# shell-scripts

Most scripts are from http://linuxcommand.org/

## Tips

```
$@ = stores all the arguments in a list of string
$* = stores all the arguments as a single string
$# = stores the number of arguments
$? = last command exit code
```

```
# 显示执行的代码片段，前期调试
set -x
# 遇见错误直接退出
set -u
```
## date

```
#当前时间戳
nowTimestamp=$(date '+%s')

#当前时间
nowStr=$(date '+%Y-%m-%d %H:%M:%S%:z')

#五分钟前时间戳
fiveMinutesAgo=$[$nowTimestamp-300]

#五分钟前时间
fiveMinutesAgoStr=$(date --date="@$fiveMinutesAgo" '+%Y-%m-%d %H:%M:%S%:z')
```
