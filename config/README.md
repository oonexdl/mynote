# 1. Softwares Install
## Pre-installion
- create new user

```shell
ssh root@your_server_ip
adduser username
# aG means --apend --groups
usermod -aG sudo username 
```

- install ssh-server

```shell
sudo apt-get install openssh-server mailutils
```    

```json
# append the following to /etc/hosts.allow
# /etc/hosts.allow: list of hosts that are allowed to access the system.
#                   See the manual pages hosts_access(5) and hosts_options(5).
#
# Example:    ALL: LOCAL @some_netgroup
#             ALL: .foobar.edu EXCEPT terminalserver.foobar.edu
#
# If you're going to protect the portmapper use the name "rpcbind" for the
# daemon name. See rpcbind(8) and rpc.mountd(8) for further information.
#
sshd : ALL: spawn (echo "security notice from host $(/bin/hostname)" ;\
echo; /usr/sbin/safe_finger @%h ) | \
/usr/bin/mail -s "ip-%h dennis security warning!!!" seasons521@126.com \
: allow

```

- change sources to aliyun

```json
# append the following to /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu trusty main restricted
deb-src http://mirrors.aliyun.com/ubuntu trusty main restricted
deb http://mirrors.aliyun.com/ubuntu trusty-updates main restricted
deb-src http://mirrors.aliyun.com/ubuntu trusty-updates main restricted
deb http://mirrors.aliyun.com/ubuntu trusty universe
deb-src http://mirrors.aliyun.com/ubuntu trusty universe
deb http://mirrors.aliyun.com/ubuntu trusty-updates universe
deb-src http://mirrors.aliyun.com/ubuntu trusty-updates universe
deb http://mirrors.aliyun.com/ubuntu trusty multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty multiverse
deb http://mirrors.aliyun.com/ubuntu trusty-updates multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty-updates multiverse
deb http://mirrors.aliyun.com/ubuntu trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty-backports main restricted universe multiverse
```

```shell
sudo apt-get update
```

## Vim
```shell
sudo apt-get install vim

vim --version
export EDITOR=/usr/bin/vim (open ./bashrc or ./zshrc, add this to last line)
alias vi=/usr/bin/vim
```
    
# Git
```shell
sudo apt-get install git git-gui git-extras

git version

# not use --global if just set in current repo
git config --global user.name "seasons521"
git config --global user.email "seasons521@126.com"
git config --global alias.s status
git config --global alias.d diff
git config --global alias.c checkout
```

# Oh-My-Zsh
```shell
sudo apt-get install zsh
zsh --version # ensure more than 4.6.9
chsh -s $(which zsh) # change zsh to default shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
    
## Chromium
- Install
```shell
sudo apt-get chromium-browser
```

## Chinese input method
- Install
```shell
sudo apt-get install fcitx-pinyin
# download sougo linux from http://pinyin.sogou.com/linux/
sudo dpkg -i sogoupinyin_(version)_amd64.deb
```

# 2. fetch code
```shell
git clone -b develop repo -o work_dir
```

# 3. install phpbrew

- Dependences
    - https://github.com/phpbrew/phpbrew/wiki/Requirement#ubuntu-1304--1404-requirement

- Install
```
curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
sudo mv phpbrew /usr/local/bin/phpbrew
phpbrew init
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
phpbrew update
```

- Install php5.6
```
phpbrew install 5.6.13 +default+fpm
phpbrew switch 5.6.13-s
phpbrew use 5.6.13
phpbrew ext install gd
phpbrew ext install mongo
phpbrew ext install redis
phpbrew fpm start
```

# 4. install nginx， sublime

## Setup xdebug

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

## Install sublime text plugin for editorconfig

[Setup Guide](https://github.com/sindresorhus/editorconfig-sublime#readme)

```
cd ~/.config/sublime-text-3/Packages/
git clone https://github.com/inetfuture/sublime-Config User
cd ~/.config/sublime-text-3/Install\ Packages
wget https://sublime/wbond.net/Package%20Control.sublime-package
```
- plugins: git, gitBuffer

## Setup nginx

- 1. Install nginx
```sh
sudo apt-get install nginx
```

- 2. Config nginx
```sh
vi /etc/nginx/conf.d/***.conf
```

## Setup Mongo

### Setup with pecl

- 1. Install Mongo
   - Follow the [setup guide](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/)

## Setup Redis

- Install Redis
```sh
sudo apt-get install redis-server
```

## Setup SCSS

- Install ruby (version > 1.9.1)
```sh
sudo apt-get install ruby ruby-all-dev
```

- Use mirror for ruby

```
gem sources --remove http://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem sources -l
*** CURRENT SOURCES ***
https://ruby.taobao.org

Ensure only ruby.taobao.org exists
```

- Install SASS
```sh
sudo gem install sass
```

## Setup grunt and bower

- 1. Install nodejs
```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
nvm install v0.12.2
nvm use 0.12.2
```

- 2. Install grunt
```sh
sudo apt-get install npm
sudo npm install -g grunt-cli
```
# 5. install supervisor

- 1. Install supervisor

  download from [pypi](https://pypi.python.org/pypi/supervisor)
  unpacking the software archive, run 
  
  ```sh
  python setup.py install
  ```
  
- 2. Config supervisor

```sh
sudo vi /etc/supervisor/conf.d/supervisor.conf
```

# 6. generate ssh keys
```shell
ssh-keygen -t rsa -b 4096 -C "xiaodongli312@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```
# 7. install terminator

```shell
sudo add-apt-repository ppa:gnome-terminator # beta ppa:gnome-terminator/nightly
sudo apt-get update
sudo apt-get install terminator
```
# 8. install tldr

```sh
sudo curl -o /usr/local/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
sudo chmod +x /usr/local/bin/tldr
```
then try `tldr tar`

# Softwares configuration

```shell
./setup.sh
```

enjoy it!
