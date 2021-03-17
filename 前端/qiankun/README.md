# qiankun（乾坤）

## 微前端的价值

- 技术栈无关，主框架不限制子框架使用的技术栈，子应用也可独立运行
- 独立开发，独立部署，独立仓库
- 解决了中后台生命周期长衍生的技术栈落后等问题

## 原理简述

- 采用 html entry，更加灵活
- 监听 url 变化，加载不同子应用（因为用 fetch 请求 html 资源，so 一些浏览器目前不兼容）

## 注意点

- 1.window.__POWERED_BY_QIANKUN__ 可以判断是否在 qiankun 环境下
- 2.__webpack_public_path__ = window.__INJECTED_PUBLIC_PATH_BY_QIANKUN__（若在 qiankun 环境下 ，得设置资源打包路径，要不资源加载会错误）
- 3.子项目也得根据是否 qiankun 环境，设置路由的 base
- 4.打包时要注意的配置
    ```
    // 以 Vue 配置为例子
    devServer: {
        headers: {
            // 得设置允许跨域，要不 qiankun 请求不到资源
            'Access-Control-Allow-Origin': '*'
        }
    },
    configureWebpack: {
        output: {
          // 微应用的包名，这里与主应用中注册的微应用名称一致
          library: packageName,
          // 将你的 library 暴露为所有的模块定义下都可运行的方式
          libraryTarget: 'umd',
          // 按需加载相关，设置为 webpackJsonp_VueMicroApp 即可
          jsonpFunction: `webpackJsonp_${ packageName }`
        }
    }

    ```



## 更新

qiankun 新增 loadMicroApp

作用：可以手动引入，像使用一个组件这样加载子应用

遇到的问题：
- 1.注册链接的方式使用子应用，子应用里面再手动加载孙子应用会有问题
- 解决：手动注册子应用，哪怕子应用有多个路由，页面里面加载孙子应用也没问题
- 注意：得 unmount 里面卸载 Vue 实例，要不然会有问题
