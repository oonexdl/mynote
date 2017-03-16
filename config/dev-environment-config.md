# 1. Softwares Setup
## Pre-installion
- create new user

```shell
ssh root@your_server_ip
adduser username
usermod -aG sudo username # aG means --apend --groups
```
    
- change sources to aliyun

```
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
- Install
    - `sudo apt-get install vim`
- Verify
    - `vim --version`
- Configuration
    - `export EDITOR=/usr/bin/vim`(open ./bashrc or ./zshrc, add this to last line)
    - `alias vi=/usr/bin/vim`
    
# Git
- Install
    - `sudo apt-get install git`
    - `sudo apt-get install git-gui`
- Verify
    - `git version`
- Configure
    - `git config --global user.name "John Doe“ `
    - `git config --global user.email “johndoe@example.com"`

# Oh-My-Zsh
- Install
    - sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
## Chromium
- Install
    - sudo apt-get chromium-browser

## Chinese input method
- Install
    - `sudo apt-get install fcitx-pinyin`
    - install sougo linux

# 2. fetch code

git clone git:  workspace

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
phpbrew switch 5.6.13
phpbrew use 5.6.13
phpbrew ext install gd
phpbrew ext install mongo
phpbrew ext install redis
phpbrew fpm start
```

# 4. install nginx， sublime

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

1. Install Redis
```sh
sudo apt-get install redis-server
```

## Setup SCSS

- 1. Install ruby (version > 1.9.1)
```sh
sudo apt-get install ruby
```

- 2. Use mirror for ruby

```
gem sources --remove http://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem sources -l
*** CURRENT SOURCES ***
https://ruby.taobao.org

Ensure only ruby.taobao.org exists
```

- 3. Install SASS
```sh
sudo gem install sass
```

## Setup grunt and bower

- 1. Install nodejs
```sh
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
. ~/.profile
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
```sh
sudo apt-get install supervisor
```

- 2. Config supervisor
```sh
sudo vi /etc/supervisor/conf.d/supervisor.conf
```
