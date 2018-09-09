# consul

https://www.consul.io/docs/install/index.html

```
# startup
sudo mkdir /data/consul
sudo mkdir /etc/consul
sudo cp config.json /etc/consul/
sudo consul agent -config-dir=/etc/consul > /var/log/consul/consul.log & disown
```
## List Services

```
curl -X GET http://192.168.222.222:8500/v1/agent/services
```
