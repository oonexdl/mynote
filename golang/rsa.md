# rsa

## generate

```
# 私钥
openssl genrsa -out keypair.pem 2048
# 从私钥生成公钥
openssl rsa -in keypair.pem -pubout -out publickey.crt
```

## PKCS1v15

### encrypt

```golang
package main

import (
	"crypto/rsa"
	"crypto/rand"
	"crypto/x509"
	"encoding/pem"
	"encoding/base64"
	"fmt"
)

func main() {
	const pubPEM = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQClcefPZqKfEZFZo0tx9WdLiLLo
2t7nEGJhLx8sEmofSHqwqbam9vb0rWkk4EFbr9cu9O5C0owANuEYllGsbUV5Fwp+
C/REsT1+Mxum+ciNYEhoN/K5hsD3lJjgxXRwve1kXCBoFsA2oj4hfAwIo88P1/ct
eVE3Hl8Bxt4KnrhwnwIDAQAB
-----END PUBLIC KEY-----`

	block, _ := pem.Decode([]byte(pubPEM))
	if block == nil {
		panic("failed to parse PEM block containing the public key")
	}

	pub, err := x509.ParsePKIXPublicKey(block.Bytes)
	if err != nil {
		panic("failed to parse DER encoded public key: " + err.Error())
	}

	pk := pub.(*rsa.PublicKey)
	encryptBytes, err := rsa.EncryptPKCS1v15(rand.Reader, pk, []byte(`18521592870`))
	if err != nil {
	        panic("failed to encrypt message: " + err.Error())
	}
	
	encryptStr := base64.StdEncoding.EncodeToString(encryptBytes)
	fmt.Println(encryptStr)
}
```

## decrypt

```golang
package main

import (
	"crypto/rsa"
	"crypto/rand"
	"crypto/x509"
	"encoding/pem"
	"encoding/base64"
	"fmt"
)

func main() {
	const prvKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQClcefPZqKfEZFZo0tx9WdLiLLo2t7nEGJhLx8sEmofSHqwqbam
9vb0rWkk4EFbr9cu9O5C0owANuEYllGsbUV5Fwp+C/REsT1+Mxum+ciNYEhoN/K5
hsD3lJjgxXRwve1kXCBoFsA2oj4hfAwIo88P1/cteVE3Hl8Bxt4KnrhwnwIDAQAB
AoGAYsgh2mmzizpYCKdBMqeNp0HVYMbd9CSKOPCDsjLEfi0uZDDQx9wJE4o+jy/+
lhnlZzoC0I8Z3D7oI2ANH+CWa4DSOlyRPeMUD+pZuhC5QhJg63iPRMEWWX3Fmm6H
mNvd0AQcCWR+gGi/Q62iVnj1r+VqgolrKuNR0qOHFsHcGdECQQDoPoPz1b5gnQLS
6f4ASTEpQ3fn4t61jy7VchlYUGo8tiRS7FbNZ1/AmnAgA4IOINKVXbvVlzB4WtzW
1YkEjwWzAkEAtl4z24OWSgT9wtCb4xaIy+cAjdsJaLhKOyJGzc86aTIVGXcrJrnU
XGoNarN2TIlmjENSShKvZbNmSUxPCYGLZQJAfGUXymAfY6JV4+DfYwnRIjf4HqVf
AsKZpExEFRClhz5rQwjdCZIoMILIMe2PGMAt60FUnbgohx6sEQo5JM7yjwJANhbu
rpbyxnWAhn21Hr+aR0/2nBxxR/wRGETsVzK1kmnmVC1CQTQwxlA2NoWP+tdt8QAu
sgWkvDdfiTH250zi+QJBAI++8Y/Kpyavcusiarz9BDJLVh2geimxYKdpG13kiVzd
IJuNVwkghBA4mfVPMnLWikx5tZw+LSHCtE+G8KRk1a8=
-----END RSA PRIVATE KEY-----`
  const message = `hello`
	block, _ := pem.Decode([]byte(prvKey))
	if block == nil {
		panic("failed to parse PEM block containing the private key")
	}

	prv, err := x509.ParsePKCS1PrivateKey(block.Bytes)
	if err != nil {
		panic("failed to parse DER encoded public key: " + err.Error())
	}

  ciphertext, _ := base64.StdEncoding.DecodeString(message)
	decryptBytes, err := rsa.DecryptPKCS1v15(rand.Reader, prv, []byte(message))
	if err != nil {
	        panic("failed to decrypt message: " + err.Error())
	}
	
	fmt.Println(string(decryptBytes))
}
```
