启动开发环境
===
```
grunt s

//start a node server on staging
node app.js &
fg
```

and then visit http://localhost:3000


Prepare Environment in CentOS
---
```
yum install -y gcc-c++ make git
yum install -y openssl-devel
git clone git://github.com/joyent/node.git
cd node
./configure
make
make install
```

```
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```
