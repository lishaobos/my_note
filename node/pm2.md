# pm2

说明：
pm2 是 node 守护程序管理器，可以帮助我们的 node 一直在线

- [官网](https://pm2.keymetrics.io/)


使用步骤:

```
// 本地测试使用
npm i -g pm2
pm2 start '..demo//src/index' // 相当于 node '..demo//src/index'

// 服务器使用(先安装 node)
npm i -g pm2
pm2 init // 初始化 pm2 配置文件

// 如下
module.exports = {
  apps: [{
    name: "pick-bottle", // 起的名字
    script: "/project/pick-bottle", // 运行文件的相对路径和绝对路径都可以
    instances: 1,
    max_memory_restart: "200M"
  }]
}
```

遇到的问题：

```
1. 服务器上使用 pm2 启动不成功项目
  kill 掉 pm2 进程，然后重新启动
```