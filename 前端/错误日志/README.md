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

注：网上的教程全部落后了

1. 先安装 docker

2. 安装 docker-compose <a href='https://github.com/getsentry/onpremise'>文档地址</a>
注：网上用 pip 安装，还有官网推荐的安装真是一大堆错误，累死个人

目前可用的：
  1. curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  2. 若第一步还失败，只能网上找到安装包直接下载下来，手动上传到服务器
  3. chmod +x /usr/local/bin/docker-compose

3. git clone https://github.com/getsentry/onpremise.git 

4. ./install.sh

5. 第 4 步执行完成之后会提示 docker-compose up -d ，执行就行了，这个是开启 sentry 服务

6. docker-compose run --rm web upgrade 创建一个用户 

7. docker-compose run --rm web createuser 如果上一步没有弹出提示创建 superadmin 就执行这个


