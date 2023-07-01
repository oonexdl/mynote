## pre-install
- create new user

```shell
ssh root@your_server_ip
adduser username
# aG means --apend --groups
usermod -aG sudo username
```

- config ssh-server

```shell
sudo apt-get install openssh-server mailutils
```
```json
# append the following to /etc/hosts.allow

sshd : ALL: spawn (echo "security notice from host $(/bin/hostname)" ;\
echo; /usr/sbin/safe_finger @%h ) | \
/usr/bin/mail -s "ip-%h dennis security warning!!!" seasons521@126.com \
: allow

```
## install vim
```shell
sudo apt-get install vim

vim --version
export EDITOR=/usr/bin/vim (open ./bashrc or ./zshrc, add this to last line)
alias vi=/usr/bin/vim
```

## install git
```shell
sudo apt-get install git git-gui git-extras

git version

# not use --global if just set in current repo
git config --global user.name "oonexdl"
git config --global user.email "oonexdl@gmail.com"
git config --global alias.s status
git config --global alias.d diff
git config --global alias.c checkout

# fetch code
git clone -b develop repo -o work_dir
```

## install Oh-My-Zsh

https://github.com/ohmyzsh/ohmyzsh

```shell
sudo apt-get install zsh curl
zsh --version # ensure more than 4.6.9
chsh -s $(which zsh) # change zsh to default shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## install chromium

```shell
sudo apt-get install chromium-browser
```
- config SwitchyOmega

```sh
wget http://fybbs.u.qiniudn.com/SwitchyOmega.crx
# open chrome://extensions/, install crx
wget http://fybbs.u.qiniudn.com/OmegaOptions1080.bak
# restore from this file
```
## install shadowsocks-client

python version:

```sh
sudo pip install shadowsocks

# exec in vps
sudo ssserver -c config.json -d start

# exec in local machine
# if blocked see https://github.com/shadowsocks/shadowsocks/pull/659
sudo sslocal -c config.json -d start
```
go version:

download release bin from https://github.com/shadowsocks/shadowsocks-go/releases, https://github.com/shadowsocks/go-shadowsocks2

```
shadowsocks-local -c config.json & disown
```

config.json
```json
{
  "server":"server_name",
  "server_port":8400,
  "local_port":1080,
  // listen on any address, others can use proxy by your IP
  "local_address": "0.0.0.0", 
  "password":"******",
  "timeout":600,
  "method":"aes-256-cfb"
}
```

docker version:

```sh
docker run -d --name shadowsocks -p 61209:8388 -p 61209:8388/udp -e PASSWORD=XXXXXX -e METHOD=aes-256-cfb gists/shadowsocks-libev.simple-obfs
```

mac version:

download release from https://github.com/shadowsocks/ShadowsocksX-NG/releases

## install shadowsocksr-cli in linux

https://github.com/TyrantLucifer/ssr-command-client

```sh
pip(pip3) install shadowsocksr-cli
# 列出可用节点
shadowsocksr-cli -l
# 通过ssr地址添加远程节点
shadowsocksr-cli --add-ssr ssr_url
# 开启socks5代理
shadowsocksr-cli -s ssr_id -p 1080
# 开启http代理(有bug待修复，可用polipo替代)
shadowsocksr-cli --http start --http-port 1087
```

## install polipo and set global proxy

- install

```sh
# ubuntu
sudo apt-get install polipo
# macOs
brew install polipo
```
- config

```sh
mv config/polipo/config ~/.polipo
```

```json
logSyslog = true
logFile = /var/log/polipo/polipo.log
proxyAddress = "0.0.0.0"
socksParentProxy = "127.0.0.1:1080"
socksProxyType = socks5
chunkHighMark = 50331648
objectHighMark = 16384
serverMaxSlots = 64
serverSlots = 16
serverSlots1 = 32
```
- restart

```sh
# ubuntu
sudo /etc/init.d/polipo restart
# macOs
brew services restart polipos
```

- test

```sh
export http_proxy="http://127.0.0.1:8123/"

curl www.google.com
```
## install wireshark

```sh
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt-get update
sudo apt-get install wireshark
sudo gpasswd -a $USER wireshark
# logout and login
```

## install input method

```sh
sudo apt-get install fcitx-pinyin
# download sougo linux from http://pinyin.sogou.com/linux/
sudo dpkg -i sogoupinyin_(version)_amd64.deb
```
## install phpbrew

- Dependences
    - https://github.com/phpbrew/phpbrew/wiki/Requirement#ubuntu-1304--1404-requirement

- install
```
curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
sudo mv phpbrew /usr/local/bin/phpbrew
phpbrew init
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
phpbrew update
```

- install php5.6
```
phpbrew install 5.6.13 +default+fpm
phpbrew switch 5.6.13-s
phpbrew use 5.6.13
phpbrew ext install gd
phpbrew ext install mongo
phpbrew ext install redis
phpbrew fpm start
```

- setup xdebug

add following lines to php.ini
```
[xdebug]
xdebug.remote_enable = 1
xdebug.remote_host = "127.0.0.1"
xdebug.remote_port = 9003
xdebug.remote_handler = "dbgp"
xdebug.remote_mode = req
xdebug.remote_connect_back = 1
xdebug.remote_autostart = 1
```

## install vscode

[link](https://code.visualstudio.com/docs/?dv=linux64_deb)

## install vscode go debug

https://github.com/golang/vscode-go/blob/master/docs/debugging.md#installation

## install nginx

```sh
sudo apt-get install nginx
```
## install Redis

```sh
sudo apt-get install redis-server
```

## install scss

- install ruby
```sh
sudo apt-get install ruby ruby-all-dev
```
- use mirror for ruby

```
gem sources --remove http://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem sources -l
*** CURRENT SOURCES ***
https://ruby.taobao.org

Ensure only ruby.taobao.org exists
```

- install sass
```sh
sudo gem install sass
```

## install nodej

- install nodejs
```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
nvm install v0.12.2
nvm use 0.12.2
```

## install supervisor

- install

  download from [pypi](https://pypi.python.org/pypi/supervisor)
  unpacking the software archive, run
  
  ```sh
  python setup.py install
  ```

- config

```sh
sudo vi /etc/supervisor/conf.d/supervisor.conf
```

## generate ssh keys
```shell
ssh-keygen -t rsa -b 4096 -C "xiaodongli312@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```
## install terminator

```shell
sudo add-apt-repository ppa:gnome-terminator # beta ppa:gnome-terminator/nightly
sudo apt-get update
sudo apt-get install terminator
```
## install tldr

```sh
sudo curl -o /usr/local/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
sudo chmod +x /usr/local/bin/tldr
```
then try `tldr tar`

## install autojump

```sh
git clone git://github.com/joelthelion/autojump.git
cd autojump
./install.py or ./uninstall.py
```

## install jq

```sh
wget https://github.com/stedolan/jq/releases/XXXXX
sudo mv jq-linux64 /usr/local/bin/jq
```

## install dive

```sh
wget https://github.com/wagoodman/dive/releases/download/v0.7.1/dive_0.7.1_linux_amd64.deb
sudo apt install ./dive_0.7.1_linux_amd64.deb
```

## configure software

```shell
./setup.sh
```

enjoy it!
