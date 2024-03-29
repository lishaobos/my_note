## 记录一下学习 Docker 的知识点

注：docker 或者其他的安装都去菜鸟教程里面找（https://www.runoob.com/docker/docker-tutorial.html）

### 常用命令
```
systemctl enable docker # 开机启动 docker
docker images # 查看下载的镜像
systemctl start/restart/stop docker # 启动，重启，停止 docker 
docker ps # 查看运行的容器
docker ps -a # 查看所有的容器
docker start/restart/stop/rm 容器名称||容器Id # 启动，重启，停止，删除容器
docker exec -it 容器名称||容器Id /bin/bash # 进入容器方便查看容器文件的路径
docker exec -it 容器名称||容器Id /bin/sh # 以交互模式进入容器
docker cp 容器名称:/etc/nginx/nginx.conf /usr/local/nginx/conf # 把容器下的 nginx.conf 拷贝到 /usr/local/nginx/cond 目录下
--restart=always 这个命令在 docker run 时候加上，可以跟随 docker 自启动
docker update --restart=always xxx 如果一开始没加，后面可以这样加
```
  
### 关于容器或者镜像的导出

```
命令：
    1.docker save 镜像名称 > ./test.tar # 保存镜像为压缩包
    2.docker export 容器名称 > ./test.tar # 导出容器为压缩包
    3.docker load --input ./test.tar # 加载镜像
    4.docker import ./test.tar 自定义名称 # 引入容器为自定义名称

区别：
    1.docker save保存的是镜像（image），docker export保存的是容器（container）；
    2.docker load用来载入镜像包，docker import用来载入容器包，但两者都会恢复为镜像；
    3.docker load不能对载入的镜像重命名，而docker import可以为镜像指定新名称。
```
  
### 配置 nginx：<a target='_blank' href='https://hub.docker.com/_/nginx/'>docker nginx</a>

```
1.拷贝 docker nginx 容器下的 nginx.conf 文件 和 log 文件夹就行了

2.映射本地文件到 docker 容器里面
说明：
    第 1 点的 （--net host）是监听所有端口，第 2 点 （-p 82:80）是把容器默认端口映射到 82 进行访问；
    -v 是进行映射的意思，冒号前面的路径是本地路径，后面的是容器里面的路径

1.nginx 监听所有端口
    docker run --name nginx-1 -d --net host  -v /usr/local/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /usr/local/nginx/html:/usr/share/nginx/html -v /usr/local/nginx/log:/var/log/nginx -d nginx

2.nginx 监听 82 端口
    docker run --name nginx-1 -d -p 82:80    -v /usr/local/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /usr/local/nginx/html:/usr/share/nginx/html -v /usr/local/nginx/log:/var/log/nginx -d nginx

3.配置 nginx（在本地路径下就行，会自动同步）
    1.include /etc/nginx/conf.d/*.conf; # 这句就注释，我们直接在 nginx.conf 里面配置负载均衡或者反向代理就行了

    2.配置
    user  nginx;
    worker_processes  1;
    error_log  /var/log/nginx/error.log warn;
    pid        /var/run/nginx.pid;
    events {
        worker_connections  1024;
    }
    http {
        include       /etc/nginx/mime.types;
        default_type  application/octet-stream;

        log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                            '$status $body_bytes_sent "$http_referer" '
                            '"$http_user_agent" "$http_x_forwarded_for"';

        access_log  /var/log/nginx/access.log  main;
        sendfile        on;
        #tcp_nopush     on;
        keepalive_timeout  65;
        #gzip  on;
        #include /etc/nginx/conf.d/*.conf;
        #这个 server 就是咱们配置的东西
        server {
            listen 89;
            server_name 192.168.40.5;
            location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
            }	
        }
    }

    3.如果我们修改完配置文件
        1.docker stop 容器名称
        2.docker start 容器名称

    4.看错误日志也和之前一样，tail -f error.log ，查看本地错误日志就行，因为之前映射了
```

### Docker 安装 MySql

```
// 目前最新版本是 8.0.21
docker pull mysql:latest

// 运行 mysql
docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql

// bash
docker exec -it mysql-test bash
mysql -u root -p

// 更改密码
alter user 'root'@'%' identified with mysql_native_password by '123456';

// 刷新
flush privileges;
```