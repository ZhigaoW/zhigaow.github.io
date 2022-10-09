# 在ubuntu上使用wireguard

### 配置使用[INI](https://zh.wikipedia.org/wiki/INI%E6%96%87%E4%BB%B6)格式

#### client

配置文件`/etc/wireguard/wg0.conf`内容如下

```
[Interface]
PrivateKey = xxxxxxxxxxxxxxxxxxxxxxxxxx
DNS = 8.8.8.8
Address = 10.0.0.2/24

# azure vps服务器
[Peer]
PublicKey = xxxxxxxxxxxxxxxxxxxxxxxxxx 
AllowedIPs = 0.0.0.0/0, ::0/0 # 转发所有流量
Endpoint = server_ip：port # 这里要替换成实际使用的ip和端口号
PersistentKeepalive = 25
```

#### server

配置文件`/etc/wireguard/wg0.conf`内容如下

```
[Interface]
ListenPort = 51820
PrivateKey = xxxxxxxxxxxxxxxxxxxxxxxxxx
Address = 10.0.0.1/24
PostUp   = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


[Peer]
PublicKey = xxxxxxxxxxxxxxxxxxxxxxxxxx
AllowedIPs = 10.0.0.2/32 # 与浙大玉泉校区则通过楼503 ubuntu的Address差不多
```

在服务器上开启流量转发

```shell
$ echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
$ echo "net.ipv4.conf.all.proxy_arp = 1" >> /etc/sysctl.conf
$ sysctl -p /etc/sysctl.conf
```



#### 字段


1. 我的理解是wireguard配置后的结果是一对虚拟网卡，其中`Interface`和`Peer`分别作用于配置自己这一端网卡的信息和对端的网卡信息。其中：
    - `PrivateKey` : 私钥由`wg keygen` 生成
    - `PublicKey`  : 公钥 `wg pubkey` 生成
2. wireguard的原理是先使用`PrivateKey`和`PublicKey`确认身份，然后再商量一个共同的密钥来加密。(因为单个密钥(私钥)的加密算法比公钥加密算法快)。 使用的时候`Interface`下面应该填写自己的私钥，`Peer`下面应该填写对方的公钥。

3. `PostUp`和`PostDown`是一个网卡启动前和启动后所执行的命令。
4. `AllowedIPs`是允许哪些字段的流量发送过来，所以server端下面的`AllowedIPs`
和client下面的`Address`相同
5. `ListenPort`是协议的端口号
6. `Endpoint`是服务器的ip地址，其实wireguard是P2P协议
7. **`DNS`: 第一次没有设置的时候vpn可以ping通国内网络，但是不能ping通国外网络，设置之后就好了**
8. `PersistentKeepalive`是检查连接时间的设置


#### 启动与停止

启动

```shell
# wg-quick up wg0
```

停止
```shell
# wg-quick down wg0
```

查看效果


```zsh
➜  ubuntu git:(master) ✗ sudo wg             
[sudo] password for wtog: 
interface: wg0
  public key: 3JuY6/TwE5xj2chaqvlTMEmBN3eF8ebrMz5/5VlB1U4=
  private key: (hidden)
  listening port: 38426
  fwmark: 0xca6c

peer: ULoeh3bKsZypRw4byT3HlZcNByt0VcP18RSTgyuzj0Y=
  endpoint: 20.89.136.250:51820
  allowed ips: 0.0.0.0/0, ::/0
  latest handshake: 30 seconds ago
  transfer: 13.58 MiB received, 2.23 MiB sent
  persistent keepalive: every 25 seconds
➜  ubuntu git:(master) ✗ 
```

### 参考资料

[wireguard official](https://www.wireguard.com/)

[wireguard 配置vpn](https://www.myfreax.com/how-to-set-up-wireguard-vpn-on-ubuntu-20-04/)
