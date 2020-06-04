<p>
<h1 align='center'>前端错误日志</h1>
</p>

## sentry
<a href='https://sentry.io/welcome/' target='_blank'>sentry</a> 是一个开源的错误日志收集平台

## 使用方法

### 下面以 Vue 举例子
```
// main.js

import * as Sentry from '@sentry/browser';
Sentry.init({
  dsn: 'https://efad257821e049cab15abaecbbcde51c@o386168.ingest.sentry.io/5220304',
  release: '1.0' // 版本
});
```

有好几种定位错误的方法，<a href='https://github.com/40thieves/webpack-sentry-plugin' target='_blank'>webpack-sentry-plugin</a> 插件是我觉得好用的一种 
```
// vue.config.js

const SentryPlugin = require('webpack-sentry-plugin');
module.exports = {
  publicPath: './',
  configureWebpack: {
    plugins: [
      new SentryPlugin({
        deleteAfterCompile: true, // 是否在打包后删除 sourceMap 文件
        organization: '6d19405cb919', // 组织的唯一标识
        project: 'test-', // 项目名称
        apiKey: 'd5e4691c666345a189d145bbde4717a9007b072723a14718a67c059bd4eab455', // 设置里的 Auth Tokens
        filenameTransform: function (filename) {
          return '~/' + filename // ~/ 这个是代表 host，后面要设置到你文件的路径，例如 ~/test/
        },
        release: '1.0', // 和 main.js 版本对应
        suppressConflictError: true // 让错误不影响构建
      })
    ]
  }
}
```

## 如何本地部署

### 1. 先安装 docker

### 2. 安装 <a href='https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-Linux-x86_64'>docker-compose</a>
  - 网上用 pip 安装，还有官网推荐的安装真是一大堆错误，累死个人，安装方法如下：
  - curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  - 若第一步还失败，只能网上找到安装包直接下载下来，手动上传到服务器
  - chmod +x /usr/local/bin/docker-compose

### 3.克隆下来文件
git clone https://github.com/getsentry/onpremise.git 

### 4.按照官网说明执行
./install.sh // 注意先关闭防火墙，再启动 docker ，现在不用手动执行第 6，7步

### 5.开启 sentry 服务
docker-compose up -d // 此命令只能在 onpremise 文件下使用，对应的 docker-compose down 是关闭服务

### 6.创建一个用户
docker-compose run --rm web upgrade

### 7.如果上一步没有弹出提示创建 superadmin 就执行这个
docker-compose run --rm web createuser

## 配置 email

下面以 126 邮箱配置

### 1.按照 onpremise 说明配置 config.yml

```
mail.backend: 'smtp'  # Use dummy if you want to disable email entirely
mail.host: 'smtp.126.com' // smtp 的 host
mail.port: 25
mail.username: 'lileo126@126.com' // 邮箱名称
mail.password: 'YUXWKKRDXHQXLJLE' // 这个是开启 IMAP/SMTP服务 给你发的验证码
mail.use-tls: false
# The email address to send on behalf of
mail.from: 'lileo126@126.com'
```

### 然后重启服务
- 1.docker-compose down
- 2.docker-compose up -d

