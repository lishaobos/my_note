##本页面记录一些 linux 系统下 nginx 的一些配置

## nginx 负载均衡

```
1.第一种负载均衡
upstream nginxDemo（随便命名，但要和下面统一）{
    server 192.168.17.130:8080    权重 weight=5 ;
    server 192.168.17.130:8081;
    server 192.168.17.130:8082;
    server 192.168.17.130:8083;
}

server {
    listen       80; # 监听80端口，默认是80
    server_name  192.168.160.129; 
    location /cats { # 所有 /cats 请求前缀的都会进行转发
        proxy_pass http://nginxDemo;
        proxy_redirect default;
    }
}

2.另一种普通的代理请求
server {
        server_name example.com;
        root /usr/local # 这个是静态资源的访问路径
        location /cats { # 所有 /cats 请求前缀的都会被代理到下面 7001的端口
            proxy_pass http://example.com:7001/;
        }
}

3.一些配置参数
server {
    listen 88;
    server_name localhost;
    client_max_body_size  10m; # 上传文件大小的限制
    location / {
        root /usr/local/nginx/html;
        index index.html;
    }
}
```
