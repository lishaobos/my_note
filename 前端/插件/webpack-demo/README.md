# webpack

说明：

webpack 是一个模块打包器，它提供了很多的功能，也支持开发者用 loader 和 plugin 去扩展功能，webpack 是基于 tapable 插件架构

## loader 和 plugin

说明：

loader 只是实现一个文件转换的功能，比如说将 a 文件转化为 b 文件

plugin 功能比较强大，他监听 webpack 整个打包过程，webpack 给你暴露 compiler 对象，也就是 webpack 包含全部生命周期的对象，compiler 每个钩子中都会生成一个这个构建节点产生的 compilation 对象，compilation 也有自己的钩子函数，且两者都挤继承于 tapable，可以在某个节点去做一些事情，比如说重新调整输出文件，或者重新格式化文件

## loader 和 plugin 简单实现

### [source-loader](./source-loader/README.md)

### [html-plugin](./html-plugin/README.md)