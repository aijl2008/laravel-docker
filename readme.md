## Build Image
```
sudo docker build -t artron/laravel-docker:1.0 .

```

## Run Container
```
sudo ./start.sh
sudo ./start.sh 192.168.0.1 //指定绑定的IP,默认为0.0.0.0
sudo ./start.sh 192.168.0.1 /data //指定挂载的目录为，默认为 ./src
sudo ./start.sh 192.168.0.1 /data ajl //指定一个tag，默认为 laravel
```

## Login Container
```
sudo docker exex -it laravel:1.0 /bin/bash

```
