# node

## commonJs

- 规范最开始是为了弥补 JS 模块化的缺陷
- 是语言层面的规范，就像 ecma 规范，主要用于 nodeJs
- 规定模块化分为引入，定义，标识符三个部分
- module 在任意模块中可直接使用包含模块信息
- require 接受标识符，加载目标模块
- exports 与 module.exports都能导出
- 加载方式是同步

## module

每个 js 被认为是一个模块，以函数包装的形式区分作用域，引用规则是如果找不到文件，那就默认为一个包，node_modules 逐层向上查找

- 任意 js 就是一个模块，可以直接使用 module 属性
- id：返回模块标识符，一般是一个绝对路径
- filename：返回文件模块的绝对路径
- loaded：返回 boolean 值，表示模块是否加载完成
- parent：返回对象存放调用当前模块的模块
- children：返回当前模块引用的其他模块，数组
- exports：返回当前模块需要到处的内容
- paths：返回数组，存放不同目录下的 node_modules 位置

## require

- 基本功能是读入并执行一个模块文件
- resolve：返回模块的绝对路径
- extensions：依据不同后缀名执行解析操作
- main：返回主模块对象


## 队列

- timers：执行 settimeout 和 setinterval
- 微任务：promise回调，nextTick（nextTick 先执行）
- pending callback：执行系统操作的回调，例如 tcp udp
- ide prepare：旨在系统内部进行使用
- poll：执行 I/O 相关的回调，例如读取文件
- check：执行 setImmediate 中的回调
- close callbacks：执行 close 事件的回调

## 事件循环

- 执行同步代码，将不同的任务添加到不同的队列
- 所有同步代码执行后会执行满足条件微任务
- 所有微任务代码执行后会执行 timer 队列中的宏任务
- timer 中所有宏任务任务执行完成后会依次向下切换队列
- 注意：在完成队列切换之前会清空微任务
- 队列执行顺序：同步 > 微任务（nextTick > promise）> timer > poll > check

### 事件循环中的问题

```
// 这个因为定时器会不稳定，所以打印出来的顺序是不固定的
setTimeout(fnc) // console.log(1)
setImmediate(fnc) // console.log(2)

/* 
    这个会一直输出 2 1，因为 I/O 操作属于 poll 队列里面，他执行完成之后先看下有没有微任务
    然后没有，队列向下切换到 check，所以先输出 2，之后再输出 1
*/
fs.read(xx, () => {
    setTimeout(fnc) // console.log(1)
    setImmediate(fnc) // console.log(2)
})
```

## Buff

- 无需 require，可直接用
- 实现 nodejs 下的二进制数据操作
- 不占据 v8 堆内存大小的内存空间
- 内存的使用由 node 来控制，由 v8 的 gc 回收
- 一般配合 stream 来使用，充当数据缓冲区