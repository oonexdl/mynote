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
git config --global user.name "seasons521"
git config --global user.email "seasons521@126.com"
git config --global alias.s status
git config --global alias.d diff
git config --global alias.c checkout

# fetch code
git clone -b develop repo -o work_dir
```

## install Oh-My-Zsh
```shell
sudo apt-get install zsh
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

```sh
sudo pip install shadowsocks
# if blocked see https://github.com/shadowsocks/shadowsocks/pull/659
sudo sslocal -c config.json -d start
```
config.json
```json
{
  "server":"server_name",
  "server_port":8000,
  "local_port":1080,
  "password":"******",
  "timeout":600,
  "method":"aes-256-cfb"
}
```
## install polipo and set global proxy

- install

```sh
sudo apt-get install polipo
```
- config

```sh
vim /etc/polipo/config
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
sudo /etc/init.d/polipo restart
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
## install shadowsocks-qt5

```sh
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install shadowsocks-qt5
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
## install sublime

```sh
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
```
[Setup Guide](https://github.com/sindresorhus/editorconfig-sublime#readme)

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

## install grunt

- install nodejs
```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
nvm install v0.12.2
nvm use 0.12.2
```

- install grunt
```sh
sudo apt-get install npm
sudo npm install -g grunt-cli
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

## configure software

```shell
./setup.sh
```

enjoy it!
