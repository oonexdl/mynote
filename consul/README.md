# consul

https://www.consul.io/docs/install/index.html

```
# startup
sudo mkdir /data/consul
sudo mkdir /etc/consul
sudo cp config.json /etc/consul/
sudo consul agent -config-dir=/etc/consul > /var/log/consul/consul.log & disown
```
