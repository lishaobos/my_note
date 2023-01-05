### 本页面用于收集各种好用的插件和组件 

## Vue

```
1.v-viewer
    说明：此插件是预览图片的组件
2.socket.io-client 
    说明：此插件是前端组件，需要后台配合使用 socket.io，他可以处理兼容性，如果 websocket 不支持，会变为 commet 长连接
3.postcss-px-to-viewport
    说明: 此插件是针对移动端开发,可以自动把 px 转为 vw 单位,达到所有设备视窗适配,详细配置去看官网
    使用:
        # in vue.config.js
        module.exports = {
            css: {
                loaderOptions: {
                    postcss: {
                        plugins: loader => [
                        require('postcss-px-to-viewport')({
                            viewportWidth: 750,
                            unitPrecision: 6,
                            minPixelValue: 1,
                            viewportUnit: 'vw',
                            fontViewportUnit: 'vw',
                            mediaQuery: false,
                            selectorBlackList: ['html', 'body'],
                            exclude: /node_modules/
                        })
                        ]
                    }
                }
            }
        }
4.vue-clipboard2
    说明：拷贝内容到粘贴版
5.vuex-persistedstate
    说明：持久化 Vuex 数据
6.vue-grid-layout
    说明：栅格化拖动
7.splitpanes
    说明：分屏拖拽
```

## 通用

```
1.storybook
    说明：此应用用于编写前端 ui组件 文档
2.vuePress
    说明：此应用用于编写前端文档
3.html2canvas
    说明：此插件用于前端截屏
4.eruda
    说明：可以方便调试移动端
5.sentry
    说明：收集错误日志，没有平台限制，极其好用
6.sortableJs
    说明：轻松拖拽
7.commander
    说明：运行 node 命令行界面
8.inquirer
    说明：询问式 node 命令行界面
9.execa
    说明：执行脚本命令
```
        
## Vscode

```
1.csscomb
    说明：格式化CSS，可排序
```

## Webpack

### Loader
```
1.file-loader
    说明：解析引用资源地址
2.url-loader
    说明：可自定义把引用的资源，例如图片编程 base64
3.svg-sprite-loader
    说明：把所有的 svg 集中管理
4.style-resources-loader
    说明：引用样式资源
```

### Plugin
```
1.clean-webpack-plugin
    说明：删除文件用的
2.html-webpack-plugin
    说明：主要解析 html
3.copy-webpack-plugin
    说明：拷贝文件
4.webpack-merge
    说明：合并 webpack 配置
5.mini-css-extract-plugin
    说明：压缩 css，得和他自己带的 loader 一起使用
6.terser-webpack-plugin
    说明：压缩 js
    注：webpack 生产模式会自动压缩，但是使用了第 5 个插件，webpack 就不会自动压缩
7.webpack-chart
    说明：Webpack统计信息的交互式饼图。
8.webpack-visualizer
    说明：可视化和分析您的包，以查看哪些模块占用了空间，哪些可能是重复的。
9.webpack-bundle-analyzer
    说明：一个插件和CLI实用程序，将包内容表示为方便的交互式可缩放树形图。
10.webpack bundle optimize helper
    说明：此工具将分析您的软件包，并为您提供可行的建议，以进行改进以减小软件包的大小。
11.bundle-stats
    说明：生成捆绑包报告（捆绑包大小，资产，模块），并比较不同版本之间的结
12.compression-webpack-plugin
    说明：压缩打包文件
```

## Rollup

- [插件总集合](https://github.com/rollup/awesome)

```
1.rollup-plugin-terser
    说明: 压缩代码
2.rollup-plugin-delete
    说明: 删除文件
3.@rollup/plugin-typescript
    说明: 编译 TS 文件
```

## Vite
```
1.unplugin-vue-components
    说明：自动导入 vue 组件
2.unplugin-auto-import
    说明：自动导入 API
```

## Node

1.commander
    说明：命令行
2.execa
    说明：执行 shell 脚本