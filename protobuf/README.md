# Proto Buffer

Google's data interchange format

# Install Protoc

```
git clone https://github.com/google/protobuf.git
cd protobuf
git submodule update --init --recursive
./autogen.sh
./configure
make
make check
sudo make install
sudo ldconfig # refresh shared library cache.
```

# Install Go Plugin

```
go get -u github.com/golang/protobuf/protoc-gen-go
```

Compile the protocol buffer definition:

```
protoc --go_out=. *.proto
```

With Grpc Support:

```
protoc --go_out=plugins=grpc:. *.proto
```

# Install Grpc-gateway plugin


```
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
```

Generate Reverse-proxy:

```
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:. \
  path/to/your_service.proto
```