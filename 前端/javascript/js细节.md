# 直接细节

## 1. js 作用域

js 可称为动态或者解释性语言，简单来说 js 代码在执行前都要进行编译

大体经过以下步骤：

- const name = 123

- 词法分析

- 语法解析（解析为 AST 语法树）

- 代码生成（将 AST 转化为及其的可执行代码）

### 1.1 RHS LHS

RHS 可以理解为等号右边的查找，LHS 为左边的查找，两者都会从当前作用域向外查找, 词法作用域的查找只会查找到一级标识，比如 obj.a.b 只会查到 obj，剩下的就交给对象访问规则了

```
// 开始预编译
// RHS 查询 boxName 在内存中的位置
// LHS 查询 name 在内存中的位置

name = boxName
```

## 2. 动态作用域

- eval

  因为 js 预编译的时候，引擎肯定会做一些优化，比如说 const name = 123，引擎会进行 LHS，找到 name 所在的地址，然后后面赋值就完了，但是如果使用下面的方法，作用域就会被修改，这个时候性能就会有所下降

  eval 会修改当前作用域，如果 var 变成 const 或者 let 就会报错，因为会自动触发严格模式
  ```
  function fnc (str) {
    eval(str)
    console.log(a)
  }

  var a = 123
  fnc('var a = 666') // 666
  ```

- with

  with 可以将一个没有或者具有多个属性的对象处理为一个块级作用域，所以这个对象里面的属性也会变为这个作用域里面的标识符，但是 var 还是不受限制

  ```
  function fnc () {
    let a = 123
    const obj = { b: 123 }

    with(obj) {
      // 进行 LHS 查询，a 不在当前作用域，然后向上查找
      a = 666
      // 进行 LHS 查询，b 在当前作用域，进行赋值操作
      b = 666
    }

    console.log(a, obj) // 666 { b: 666 }
  }
  ```

总结：

js 引擎会在编译阶段进行优化，对于代码进行静态分析，并先确定所有变量和函数内存中的定义位置，然后再执行，这个时候就能很快地找到变量和函数，但是如果有了 eval 和 with，就无法有效的进行静态分析，所以性能很差


## 3. 提升

函数提升到当前作用域顶部，比 var 优先级别高

只有 var 声明的全局变量才会和 window 挂钩
```
var a = 123
window.a // 123

const a = 123
window.a // undefined

let a = 123
window.a // undefined
```


## 4. this

- apply,call 第一个参数如果是 undefined || null，那么 this 就是 window
- bind 之后的函数再 bind 也没有用

- new 的优先级高于一切

  ```
  function fnc (val) { this.a = val }
  const obj = { fnc }

  const b = new obj.fnc(4)
  console.log(obj, b) // { fnc }, { a: 4 }
  ```

  ```
  function fnc (val) { this.a = val }
  const a = { }
  const b = fnc.bind(a)

  const c = new fnc(4)
  console.log(a, c) // { }, { a: 4 }
  ```

- new 的过程
  - 创建一个原型链接的对象
  - 构造函数的 this 指向创建的对象，执行构造函数
  - 如果 return 了对象，就返回这个对象， return 其他类型数据会被忽略，没有 return 就返回 this, 也就是创建的对象


## 5. 对象

在对象中，key 永远是字符串，如果用其他类型作为 key，那么会被转化为 string 类型

- Object.getOwnPropertyDescriptor 获取属性描述符
- Object.getOwnPropertyDescriptors 获取所有的属性描述符
- Object.setPrototypeOf 设置原型对象
- Object.create 创建一个原型确定的对象
- Object.isPrototypeOf 代替 instanceof
- Object.getOwnPropertySymbols 获取 symbol 值

## 6. class

class 的原理还是基于原型继承

```
var a = { fnc(){ console.log(super.name) } }
Object.setPrototypeOf(a, { name: 666 })
a.fnc() // 666
```

## 7.行为委托

类的继承和行为委托两种模式可以实现一样的功能

```
const a = {
  name: 'a',
  say() {
    console.log(this.name)
  }
}

const b = {
  name: 'b'
}

Reflect.setPrototypeOf(b, a)

b.say()
```


## 8.for of

for of 可以迭代任何具有 Symbol.iterator 属性的结构

generator 函数就是一个 iterable，yield * 相当于 for of


## 9. 类型

### 9.1 js 内置类型

- 除了对象之外，其他的都称之为基础数据类型
  - null
  - undefined
  - string
  - number
  - boolean
  - object
  - symbol


- 字符串用 string 对象的方法

  ```
  // aaa 会在执行的过程中被转为 string 对象，所以可以使用 string 的方法
  'aaa'.toUpperCase() // AAA
  ```

- number 的一些方法
  - toFixed 保留几位有效数字
  - toPrecision 指定数字的显示位数
  - toExponential 用指数方式显示

- 数字用 number 对象的方法

  ```
  // 因为一个有效的数字会先被认为是数字字面量，然后才是对象访问运算符

  // 无效语法
  12.toFixed(2)

  // 有效语法
  (12).toFixed(2)
  12.0.toFixed(2)
  12..toFixed(2)
  12 .toFixed(2)
  ```

- 0.1 + 0.2 === 0.3 // false

  因为 js 中二进制浮点数的运算不是完全精确，所以运算结果会有一些误差 

  - Number.EPSILON（机器误差范围，为 2^-52）
  - js 中如何判断 0.1 + 0.2 是否等于 0.3

    ```
    const compare = (n1, n2) => Math.abs(n1 -n2) < Number.EPSILON

    compare(0.3, 0.1 + 0.2) // true
    ```

- void

  void 不会改变程序的结果，只会让表达式不返回值

  ```
  const a = 1
  console.log(void a, a) // undefined 1
  ```

- isNaN
  - window.isNaN 只要不是数字，都是 true
  - Number.isNaN 只有 NaN 类型才是 true


- Object.is（严格比较）
  
  ```
  // NaN 是 js 中唯一一个不等于自身的
  NaN === NaN // false
  0 === -0 // true

  Object.is(NaN, NaN) // true
  Object.is(0, -0) // false
  ```

### 9.2 类型转换

- Object.create(null) 没有 valueOf 和 toString 方法，所以无法隐式转换

- 隐式转换：
  - 依次调取下面的方法，如果有此方法且返回了原始值（也就是基本数据类型）就去运算
  - 1. Symbol.toPrimitive
  - 2. valueOf
  - 3. toString

- 神奇的加法

  ```
  [] + {} // "[object Object]"

  // 因为 {} 会被认为是 block，所以相当于 +[]
  {} + [] // 0
  ```


## 10. 异步

针对于之前的事件订阅，会有以下的几个缺点：

- 回调地狱
- callback 执行时机不确定
- callback 是否执行也不确定

promise 解决了以下：

- 控制反转，并且可信任（promise 状态不可改变）
- callback 时机自己决定
- callback 肯定会执行，要么错误，要么顺利
- 注册多少个 then，就会执行多少个


## 11. 小知识点

### block

查看浏览器执行的 stack，发现 let const 的变量也会提升，所以不同于 var 的只是你在未声明前使用会报错
```
const name = 222

function fnc () {
  console.log(name)
  const name = 123
}

fnc() // 报错
```

### 默认参数

函数参数的变量是按照顺序来声明的
```
function fnc (a = 1, b = a + 1, c = b + 1) {
  console.log(a,b,c)
}

fnc(2) // 2, 3, 4
```

### 解构赋值

对象剩余参数收集（数组也可以）
```
const { a, ...obj } = { a: 123, b: 456, c: 999 }
console.log(a, obj) // 123, {b: 456, c: 999}
```

反向赋值
```
let a;
let a1;
let obj = {};

// 加括号是因为不会被认为 block
({a, b: a1, c: obj.a} = { a: 1, b: 2, c: 3 })
console.log(a, a1, obj) // 1, 2, {a: 3}
```

### 模板字符串

```
const fnc = (str, ...vals) => console.log(str, vals)

fnc`aaa${123}bbb${456}` // ['aaa', 'bbb', ''], [123, 456]
```