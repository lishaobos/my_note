# Redis

说明：做缓存用，读写数据得效率极高

- [官网](https://redis.io/)
- [常用命令](https://blog.csdn.net/u010191034/article/details/83383448)
- [ioredis：作为 node client](https://github.com/luin/ioredis#readme)

安装步骤：

```
$ wget https://download.redis.io/releases/redis-6.2.3.tar.gz
$ tar xzf redis-6.2.3.tar.gz
$ cd redis-6.2.3
$ make
```

安装遇到的问题：

```
// redis.conf 启动的时候记得指向该配置文件

protected-mode no // 去掉保护模式
bind 127.0.0.1 -::1 // 把这行注释掉
daemonize yes // 后台运行
```