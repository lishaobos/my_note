## Rollup

#### 虚拟模块

虚拟模块是模拟一些项目中并不存在的模块，并进行处理，也不一定非得 virtual 开头，需要注意的是如果你在写一个处理虚拟模块的插件：

```js
resolveId(id) {
  // 加这个前缀是为了让 bundler 知道这是一个虚拟模块，不被其他所处理
  return '\0' + id
}
```

## Unplugin

待补充.


## langchain

给予 gpt 身体和工具


stable diffusion

图片生成。

Babyagi


sad talker

图片说话


tiptap

简易聊天

css  

overflow hodden 可以让自适应宽度容器不被子元素的内容撑开，让子容器具备滚动条
