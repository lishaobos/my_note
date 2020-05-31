



***原型链
    https://www.jianshu.com/p/116ea3be6ef5
    https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Inheritance_and_the_prototype_chain
    https://www.zhihu.com/question/34183746
    https://www.cnblogs.com/libin-1/p/6014925.html
    *** https://chen-cong.blog.csdn.net/article/details/81211729
    我们需要牢记两点：①__proto__和constructor属性是对象所独有的；② prototype属性是函数所独有的，因为函数也是一种对象，
    所以函数也拥有__proto__和constructor属性。
    __proto__属性的作用就是当访问一个对象的属性时，如果该对象内部不存在这个属性，那么就会去它的__proto__属性所指向的那个对象（父对象）里找，一直找，
    直到__proto__属性的终点null，然后返回undefined，通过__proto__属性将对象连接起来的这条链路即我们所谓的原型链。
    prototype属性的作用就是让该函数所实例化的对象们都可以找到公用的属性和方法，即f1.__proto__ === Foo.prototype。
    constructor属性的含义就是指向该对象的构造函数，所有函数（此时看成对象了）最终的构造函数都指向Function。




***关于Object.defineProperty(obj,'yo',{ // obj是定义的对象，yo是属性
    set(e){
        // 当 obj.yo = anythine 就会进来这个函数，e 是我们修改的 obj对象的yo属性的值
    },
    get(){
        // 当 obj.yo  就会进来这个函数
    },
    value:'xxx', // 这个就是我们定义的 yo 属性的值
    enumerable: false // 这个是 false 就是代表不可枚举, true 就是代表可枚举
    configurable: false //如果为false,就不能设置他的value
})
    1.对象的可枚举属性和不可枚举属性的区别
        1.可枚举属性就是我们 for in 循环可以打印出来的属性
        2.不可枚举属性我们在对象中可以使用，也可以看见，但是 for in 循环是打印不出来这个属性的

***关于es6连续箭头函数
    let yo = a => b => return a + b
    相当于 function yo(a){
            return function (b){
                return a + b
            }
          }
    执行形式：yo(2)(3) //都是这样
    
    
    
***关于 js 执行上下文，环境栈
    **声明函数的区别
        1.let a = function () {console.log(111)}
        2.function a () {console.log(111)}
        speaker:
            第一种是必须在 let 语句之后函数才生效
            第二种是会变量提升到最高级别，比 var 这些还高，并且在函数声明之前就可以调用,并且 a.name(提供这个属性，就是函数的名字)
     **apply call bind
        1.apply，call，bind 都是可以改变函数的执行上下文
        2.apply(object,[]) call(object,'','') bind(object,'',) //这是使用的方式，如果不传参数，只写一个参数就行了
        3.apply 和 call 都是让函数的 this 指向指向到我们传入的 object,bind也是，不过 bind 是返回一个新的函数
        4.apply，call，这连个方法执行的时候只有该次 this 的指向是我们传入的对象，其他时候原本函数执行的时候还是指向原来的
        5.bind绑定会返回一个新函数，所以这个新函数每次执行的时候 this 都会指向到我们绑定的 对象
        6.一些点说一下
            假设 function a(){
                    console.log(this.num)
                   }
                let b = {num:123}
                a.apply(b)
                然后 a() 就会打印出来 123
            还有之前的一个疑惑
                 function a(){
                    console.log(this.num)
                  }
                  var b = new a; b.num = 123
                  a() 打印出来 undefined //按理来说 this 不是应该指向我们实例的对象身上吗
                  因为 var b = new a 这段代码会重新执行 a 函数，但这个时候 对象没有实例化结束，this指向的是 a函数，
                  因为函数本身也是一个对象，所以这个时候 this 指向的是自身当执行完成之后会创建一个新对象 b，会执行原型链接，
                  将构造函数 a 的作用域赋给 b 对象，也就是 this的指向指到了 b ，如果函数内部没有返回新的对象的话，new 表达式会自动返回这个新对象。
                  
                  a()这种执行 this 还是指向的是 window 对象
                  
 ***ES6中的一部分东西
    1.let 和 const
        1.例子：
              for (let i = 0; i < 3; i++) {
                let i = 'fuck'
                console.log(i)
              }
              上面不会报错，因为 for 循环相当于两层作用域，小括号和大括号，所以 let i 是不会报错的
    2.箭头函数
        1.函数体内没有 this，只能从外层继承,因为没有 this，所以也不可以作为构造函数，new 对象就是不可以的。
        2.不可以使用 arguments对象。
        3.不可以使用 yield
        4.不适用场景：
            因为没有 this，所以 call apply bind 这些方法对箭头函数式不起作用的
            例子：
                const cat = {
                     lives: 9,
                    jumps: () => {
                        this.lives--;
                    }
                   }
             执行cat.jumps的时候，如果是普通函数就会奏效，如果是例子中的箭头函数，就不会奏效，
             **原因是对象不构成单独的作用域，导致jumps箭头函数定义时的作用域就是全局作用域。（打破了大括号作用域的认知）
                  
***零散的记录一些 js 基础东西
    1.break continue return 以及 标签语法的使用
        1.break 是跳出他所在的 for 循环，循环结束。
        2.continue 是跳出该次循环，继续 for 循环
        3.return 就不多说了
        4.标签语法配合 break 和 continue
            例：start:for(let i=0;i<10;i++){
                    for(let j=0j<3;j++){
                        if(j === 2){
                            break start; //跳出该标签的循环，就是退出外层循环；start 名称可以随便写
                            continue start; //跳出此次标签所对应的，也就是外层循环的该次循环，然后继续执行。
                        }
                    }
                }
                
    2.arguments 对象
        1.非箭头函数内部都包含此对象，该对象是函数传递进来的参数列表，可以不用形参接收。
        2.function a(a,...mystyle){} //这种定义形参是可以访问剩余的变量集合。
        3.class costructor 里面也可以访问 arguments 对象。
        4.arguments.callee 可以访问到该函数，也可以执行该函数
            例：function a(num){
                if(num == 1) return 1
                arguments.callee(1)
            }
        
    3.函数参数传递中引用赋值的变量，照样是引用赋值。可以动一发而牵全身。
        1.若给接收对象的变量重新赋值，也只是重新改变了这个变量的内存指向，不会改变原始对象；
            例：var a = {};
                function b(obj){
                    obj = {};
                    obj.name = 123 //a对象是无变化的
                }
                
    4.typeof 和 instanceof
        1.typeof 可以帮我们检测是什么类型
        2.instanceof 只应用于引用变量，用于判断是哪种类型的引用变量,也用于判断实例与原型的从属关系。 //例： var a = []; a instanceof Array
        
    5.作用域链
        当代码在一个环境中执行时，会创建变量对象的一个作用域链，作用就是保证执行环境和函数有序的被访问，拿嵌套函数举例，最里面的函数访问变量，
        先从自身开始，然后一层一层访问外部环境，最后就是我们的全局环境，搜索到变量时就搜索终止，不会再往外。（全局环境默认就是 window 对象）
    
    6.toFixed()返回小数点保留几位，toString(num)返回 num 进制的数字（前提是数字类型的调用这俩）
    
    7. 动态原型模式：
            function a(){
                this.name = 123;
                //这样的好处是先判断原型里面是否有该函数，没有再添加
                if(typeof this.say != 'function'){
                    a.prototype.say = function (){}
                }
            }
    
    8.关于 new 关键字，和原型链的理解。
        1.new 一个构造函数会发生如下几步
            1.创建一个新对象。
            2.将构造函数 this 指向新对象。
            3.执行构造函数。
            4.建立原型链接（将对象的原型指向构造函数对应的原型对象）。
            5.返回对象。
         2.根据 new 关键字的原理说说原型继承。
            1.普通修改原型(不论什么时候修改原型都会整体响应)
                function a(){this.name=123}
                var a1 = new a();
                a.prototype.cs = 666;
                a1.cs // 666
            2.重写原型的两种方式。
                1.后重写
                function a(){this.name = 123};
                var a1 = new a();
                a.prototype = {
                    constructor:a,
                    cs:666
                }
                a1.cs // undefined
                var a2 = new a();
                a2.cs // 666
                reason:因为 prototype 只是一个指向原型内存地址的属性，我们已经先实例化 a1 ，a1的原型已经指向了原始的原型对象，
                       我们重写原型对象，只是改变构造函数 prototype 的指向，a1还是指向原来的原型，a2 在 new 的时候，因为指向
                       已经改变到了另一个内存地址，所以 a2 会有 cs 属性。                
                2.先重写（不多说了）
                
    9.记录一点 this 的知识。
        ***函数内部的 this 总会指向调用它的对象。
        ***this 不同于作用域链的变量，他只会在自己的作用域查找，除非像箭头函数这种只能继承的。
        下面举几个小例子：
            1.
            let name = 123;
            let a = {
                name:666;
                say(){
                    return function(){
                        return this.name
                    }
                }
            }
            a.say()() // 123
            2.
            let name = 123;
            let a = {
                name:666;
                say(){
                    return () => {
                        return this.name
                    }
                }
            }
            a.say()() // 666 因为箭头函数继承了 say 函数的 this，此情况理解较复杂，只要say函数调用的时候，执行了上下文，这个箭头函数就是此刻继承的 this，也就是调用 say 方法的来源
            3.
            let name = 123;
            let a = {
                name:666;
                say(){
                    return function(){
                        return this.name
                    }
                }
            }
            let b = {name:777}
            b.say = a.say()
            b.say() // 777
            4.箭头函数的奇怪之处。
                1.箭头函数与普通函数的作用链域在定义的时候就确定了，哪怕是闭包，也是一样的。
                2.普通函数与箭头函数的 this 变化。
                    1.普通函数的 this 指向总是指向调用他的函数。
                    2.箭头函数因为没有 this ，所以一开始就只能继承外部的 this，然后你不管你用谁调用箭头函数，this 指向的都是一开始继承的，
                      怎么都不会改变。（奇怪）
                      
    
***关于 js 不断新增的知识
    1.元素节点的 classList 属性
      元素的 classList 属性是返回他的类名数组
      提供的方法：
        1.add();
        2.contains(); //如果包含这个类名就返回 true 反之 false
        3.remove();
        4.toggle()
        jq 那些也是根据这些来的
    2.hasFocus // 这个方法是判断元素有没有获取焦点，从而知道用户与页面的交互效果
    3.document.readyState == 'complete' // 判断 document 对象是否加载完毕
    4.innerHTML 对应的 outerHTML 好像没啥区别？
      1.执行 innerHTML 和 outerHTML 时候浏览器就会创建一个 html 解析器，这个解析器通常是在浏览器级别的代码（一般 C++ 编写），所以效率快得多
    5.scrollIntoView 方法可以在所有 HTML 元素上使用，浏览器直接滚动到改节点
    
    6.某个元素支持的每种事件都可以使用一个相应的事件处理程序同名的 HTML 特性来决定
      例：
          1.<div onclick='a(event,1)' /> // a 函数就会接收到事件对象和 1 这个参数
          2.使用 DOM 0级方法和 2级方法指定的事件处理程序被认为是元素的方法，因此这时候的事件处理程序
            是在元素的作用域中运行，也就是说程序中的 this 引用当前元素，这个时候最骚的东西出现了，箭头
            函数依旧那么牛皮。
    7.hashchange 事件是 url # 后面的字符串变化会触发的事件
    
    8.如果不采用事件委托，就要给每个元素绑定事件执行函数，因为函数是对象，如果有数不清的元素需要添加事件，
      因为对象会占用内存，对象越多，页面越卡，所以还是能用事件委托就用
    
    9.拖放事件
      介绍：拖放事件是针对页面中可以拖动的元素所能触发的事件，例如图片和选中的文字
      1. dragstart //拖动开始触发的事件
      2. drag // 拖动时触发的事件，当然 mousemove 事件在这个时候也是可以触发的
      3. dragend // 拖动结束时触发的事件
      4. 当某个元素被拖动到一个幼小的放置目标上时，下列事件会依次发生
        1.dragenter
        2.dragover
        3.dragleave 或 drop
      5.默认情况下，图像，链接和文本是可以拖动的，其他的元素可以通过设置属性来进行拖动
        1.假设 <div draggable='true' /> // 只要加这个属性，元素就是可以拖动的
      6.详细描述
        1、被拖对象：dragstart事件，被拖动的元素，开始拖放触发
        2、被拖对象：drag事件，被拖放的元素，拖放过程中
        3、被拖对象：dragend事件，拖放的对象元素，拖放操作结束
        4、经过对象：dragenter事件，拖放过程中鼠标经过的元素，被拖放的元素“开始”进入其它元素范围内（刚进入）
        5、经过对象：dragover事件，拖放过程中鼠标经过的元素，被拖放的元素正在本元素范围内移动(一直)
        6、经过对象：dragleave事件，拖放过程中鼠标经过的元素，被拖放的元素离开本元素范围
        7、目标地点：drop事件，拖放的目标元素，其他元素被拖放到本元素中,就是鼠标拖动点在本元素中，然后松开
      7.注意
        目标地点若要触发 drop ，必须他的 dragover 事件里面阻止浏览器默认行为
      8.dataTransfer 对象
        说明：此对象可以保存被拖动的元素的数据，它可以保存一项或多项数据、一种或多数数据类型。通谷一点讲，就是可以通过它来传输被拖动              的数据，以便在拖拽结束的时候，对数据进行其他的操作。
        方法：
            1.设置
                document.getElementById('source').ondragstart = function (event) {
                    event.dataTransfer.setData('some-key', 'some-value');
                };
            2.获取
                document.getElementById('target').ondrop = function(event){
                    event.preventDefault(); // 拖动的默认处理方式是在新窗口打开，所以阻止其执行
                    let value = event.dataTransfer.getData('some-key');
                    // some-value
                }
        
    10.auxclick 是鼠标右击事件
      1.回顾一波事件
        window 的 contextmenu 事件里面有三种阻止右键菜单的方法，并且在这个事件里你可以自己搞个右键菜单出来
        1. event.preventDefault();
        2. event.stopPropagation();
        3. return false; // 前两种是非 IE 和 IE
    11.元素的 style 的 cssText 属性是查看元素的行间样式（字符形式），可以直接修改
    12.document.styleSheets 返回的是所有样式表的规则。往里面找到 CSSStyleRule 属性，里面就放着 cssText 属性
    13.insertRule 方法的使用
        1.var sheet = document.styleSheets[0];
        2.sheet.insertRule("body{ background: pink }",0) // DOM 方法，添加规则
        3.sheet.deleteRule(0) // DOM 方法，删除规则，参数是规则的索引
    14.dataset 的使用（dom元素的自定义属性，是一个 DOMStringMap）
        例：<div id='a' />
            1.a.dataset.sk = 123 // <div data-sk='123' id='a' />
            2.a.dataset // 123
    15.数组的一些操作方法的细节点
        1.for in 循环是不可逆的，让 i-- 也是无济于事的，只有原始的 let i =0; i<10; i++ 这种循环是可逆的。   
        2 反向 for 循环，如果有 splice 操作，是不用 i++;正向循环还得 i--;
        3.map 和 forEach 都是不可停止的，是不可以退出的，而且在这俩函数里面对数组 push 或者其他，map 和 forEach 循环次数是不改变的。
        4.map 和 forEach 可以通过抛出错误来停止他，但如果这样，map 是没有任何返回的。
        5.map 和 forEach 里面如果是数组对象结构，修改对象是奏效的。 例如：var a = [{num:123}] a.map( _ => _.num = 666)
        6.map 的第二个参数是提供给回调函数的 this 值
        7.find 和 filter 方法如果是对于数组对象结构，里面返回的也是内存地址指向，修改返回的对象，对原有的数据是可以改变的。
        8.some 和 every 方法是可以中断的，前者 return true，后者 return false
        9.Array.includes() 该函数和 Array.indexOf() 都是判断是否包含这个元素,前者返回 Boolean 值
        10.iterator 数组迭代玩法
            1.for of 循环是可以解构循环的
                例：
                    let arr = [{name:123}]
                    for(let {name} of arr){
                        console.log(name) //123 
                    }
            2.for of 循环配合 数组的 entries 函数
                例：
                    let arr = [{name:123}]
                    for(let [{name},index] of arr){
                        console.log(name,index) //123,0 
                    }
        11.数组的扁平化
            1.Array.flat() 直接可以扁平,但存在兼容问题
            2.利用 reduce 和 concat 简单递归
                注: concat 方法里面的参数,会把第一层不论是数组还是单个,全部展开,数组里面的数组就不行了
                function flatten(ary) {
                    return ary.reduce((pre, cur) => {
                        return pre.concat(Array.isArray(cur) ? flatten(cur) : cur);
                    }, []); // 这个空数组是提供给回调函数的初始值,可以不选
                }
         

    16.判断 dom 元素的坐标
        1.dom.getBoundingClientRect() //返回当前 dom 元素距离视窗的各个坐标
        2.dom.getClientRects() //如果是块级元素，和第一个方法返回的是一样，如果是内联元素，例如：
            <span>
                13
                eqweqwe
            </span>
          这种有很多行的，他会返回包含每一行的坐标数组
        3.document.elementFromPoint(x,y) //x，y均为数字，从视窗左上角计算，返回当前坐标最顶层的元素

    
     
***历史状态管理
    说明:  历史状态管理是现代 web 应用开发中的一个难点，用户的每次操作不一定会打开一个全新的页面，因此后退和前进按钮就失去了
           然后 H5 通过更新 history 对象为管理历史状态提供了方便
    1.history.pushState(Object,String,url) //这个方法会增加历史状态，会触发 hashchange 事件
    2.history.replaceState(Object,String,url) //这个方法会替换当前状态，但是触发不了事件
    3.popstate 事件会监听到浏览器的前进后退的事件
    4.hashchange 事件会监听到浏览器的地址的变化，比如说 pushState 就会触发 hashchange 事件。

***错误处理与调试
    1.throw 可以直接抛出错误 例：throw '错误啦'
        1.在遇到 throw 操作符时，代码会立即停止执行，仅当有 try-catch 语句铺货到被抛出的值时，代码才会继续执行。（慎用）
        2.错误类型
            1.Error
            2.EvalError
            3.RangeError
            4.ReferenceError
            5.SyntaxError
            6.TypeError
            7.URIError
    2.try catch
        try{
            do somthing
        }catch(error){
            //这里面我们可以根据错误类型来处理错误
            if (error instanceof TypeError){
                // 处理类型错误
            } else if (error instanceof ReferenceError){
                // 处理引用错误
            } else {
                // 处理其他类型的错误
            }
        }finally{
            //这个不管try 还是 catch 都会执行
        }
    3.当 try catch 语句发生错误时，浏览器会认为错误已经被处理了，因而不会抛出错误
    
*** websocket
  说明：首先，同源策略对 websocket 是不生效的，因此可以通过他来连接到任何站点，至于是否会与某个域的页面通信，则完全取决于服务器。
       使用标准的 HTTP 服务器无法实现 websocket，只有支持这种协议的专门服务器才能正常工作，由于 websocket 使用了自定义的协议，
       所以 url 也是不一样的，未加密的链接不是 http:// 而是 ws:// 加密的不是 https:// 而是 wss:// 
  1.websocket 的 readyState 属性
    readyState 为 0 的时候 // 正在建立连接 
    readyState 为 1 的时候 // 已经建立连接 
    readyState 为 2 的时候 // 正在关闭连接 
    readyState 为 3 的时候 // 已经关闭连接 
  2.websocket 有三个响应的事件
    1.open // 在建立连接的时候触发
    2.error // 在发生错误的时候触发
    3.close // 在关闭的时候触发
    注意：websocket 对象不支持 Dom 2级事件，所以这三个事件只能写成 Dom 0级事件

*** 重绘和回流
    参考网站：https://segmentfault.com/a/1190000016458627
    1. 防止阻塞渲染
    页面中的css 和 js 会阻塞html的解析，因为他们会影响dom树和render树。为了避免阻塞，我们可以做这些优化：

    css 放在首部，提前加载，这样做的原因是： 通常情况下 CSS 被认为是阻塞渲染的资源，在CSSOM 构建完成之前，页面不会被渲染，放在顶部让样式表能够尽早开     始加载。但如果把引入样式表的 link 放在文档底部，页面虽然能立刻呈现出来，但是页面加载出来的时候会是没有样式的，是混乱的。当后来样式表加载进来后，     页面会立即进行重绘，这也就是通常所说的闪烁了。
    
    js文件放在底部，防止阻塞解析
    一些不改变dom和css的js 使用 defer 和 async 属性告诉浏览器可以异步加载，不阻塞解析
    2. 减少重绘和回流
    重绘和回流在实际开发中是很难避免的，我们能做的就是尽量减少这种行为的发生。

    js尽量少访问dom节点和css 属性
    尽可能的为产生动画的 HTML 元素使用 fixed 或 absolute 的 position ，那么修改他们的 CSS 是不会 Reflow 的。
    img标签要设置高宽，以减少重绘重排
    把DOM离线后修改，如将一个dom脱离文档流，比如display：none ，再修改属性，这里只发生一次回流。
    尽量用 transform 来做形变和位移，不会造成回流
    3. 提高代码质量
    这最能体现一个前端工程师的水平了，高性能的代码能在实现功能的同时，还兼顾性能。下面是一些好的实践：

    1）html：
    dom的层级尽量不要太深，否则会增加dom树构建的时间，js访问深层的dom也会造成更大的负担。
    meta标签里需要定义文档的编码，便于浏览器解析
    2）css：
    减少 CSS 嵌套层级和选择适当的选择器，可参考如何提高css选择器性能
    对于首屏的关键css 可以使用style标签内联。可参考什么是关键css
    3）js：
    减少通过JavaScript代码修改元素样式，尽量使用修改class名方式操作样式或动画
    访问dom节点时需要对dom节点转存，防止循环中重复访问dom节点造成性能损耗。
    慎用 定时器 和 计时器， 使用完后需要销毁。
    用于复杂计算的js代码可以放在worker进程中运行
    对于一些高频的回调需要对其节流和消抖，就是 debounce 和 throttle 这两个函数。比如scroll和touch事件

***一些 js 高级技巧
  1.防篡改对象
    1.不可扩展对象
      Object.preventExtensions(对象) // 这个方法可以让对象不能添加属性和方法，但原来的可以修改
      Object.isExtensible(对象) // 检查对象是否是不可扩展对象
    2.密封的对象
      Object.seal(对象) // 密封对象不可扩展，而且已有成员的 configurable 特性将设置为 false，这就意味着不能删除属性和方法
      Oject.isSealed(对象) // 检查对象是否被密封
    3.冻结的对象
      Object.freeze(对象) // 冻结对象既不可以扩展，而且对象的 Writeable 特性被设置为 false 如果设置 set 函数，访问器属性仍然是可写的
      Object.isFrozen(对象) // 检查对象是否被冻结
  2.数组分块技术
    说明：运行在浏览器的 javascript 都被分配了一个确定数量的资源，javascript 被严格限制了，其中一个限制是长时间运行脚本的制约，如果 javascript
         长时间运行脚本，到达时间限制之后，浏览器会弹出一个错误的对话框，询问用户继续执行还是停止他
    1.大循环
      例：for(let i in arr){
        process(arr[i])
      }
      如果数组长度太大导致大循环，正好 javascript 是单线程的，所以阻塞时很难受的
      1.数组分块技术 （实在是妙哇）
        function a (arr){
          if(arr.length == 0) return
          let item = arr.shift();
          setTimeval( _ => {
            process(item)
            arguments.callee(item)
          },300)
  3.说一说 setInterval 和 setTimeout （javascript 除了主线程还有一个执行队列，dom 事件也是被加入执行队列，绕后等待执行的）
      也想起以前为什么要用 setTimeout 来实现 setInterval 这个问题了
      说明：不论是 setTimeout 还是 setInterval 这俩一执行，里面的函数就会在设置的时间后被加入队伍等待执行，然后 javascript 很聪明，如果他检测到队列中有一个定时器
           那么就不会把函数加入队列，所以如果用 setInterval 如果计时器里面的函数执行时间过长，假设执行时间为 1s，然后计时器每 900 毫秒执行一次，那么在计时器准备添加
           到队列的时候发现上一个计时器还在，那么就不会加入队列，然后就会等两个 900 毫秒，所以还是比较恶心的，这时候为什么用 setTimeout 实现 setInterval 原因就出来了。
    1.顺便说一嘴函数节流
          // 这样就实现了一个简单的函数节流，假设鼠标点击后触发，这个不管你点的多快，还是在最后一次点击过 300 毫秒执行
          function a(func){
            clearTimeout(func.timeId);
            func.timeId = setTimeout( _ => {
              func()
            },300)
          }
  4.Web 计时
      window.performance 属性里面的 timing 是页面加载或者请求等等一些时间，我们可以更好地了解到页面在浏览器加载的过程中经历了哪些阶段
  5.Web Workers
  6.import 和 require 的区别
    1.import 是 es6 的语法，require 是AMD的语法
    2.import 是在编译时调用， reuqire 时运行时调用，所以 import 得放在开头，require 可以放在任何地方
    3.import 现在浏览器大多没有实现，所以现在一般项目中的 import 最后还是得编译成 require
    4.require 在引用基础数据类型的时候是赋值，引用复杂数据类型，比如是对象，数组，都是浅拷贝（注意注意）


*** dom 渲染时机
    说明：浏览器中执行 js 和 ui 渲染是两个引擎，两个是不会共同进行的，经过测试发现 dom 修改后不会立即渲染，而是会等到 js 的执行栈空了之后
    进行渲染，是在事件队列的 microTask 和 macroTask 之前进行渲染的，而且 dom 短时间内修改多次，浏览器会集中在一起执行，不会一次次的渲染，
    因为 dom 操作一般都伴随 repaint 和 reflow ，所以代价是很昂贵的。
    注：dom 操作是同步的，但是渲染是异步的。

    1.代码：
    function task (time){
        let start = new Date().getTime();
        do{
            var end = new Date.getTime();
        }while( end - start >= time)
        console.log( time );
    }
    setTimeout( _ => {
        console.log('开始');
        document.body.style.background = 'pink';
        task(5000);
        console.log('结束');
    },1000)
    结果：
        1.输出 开始
        2.浏览器空转 5s，输出 5
        3.输出 结束
        4.dom 渲染
    结论：执行栈不为空的时候 dom 不会渲染

    2.代码：
    function task (time){
        let start = new Date().getTime();
        do{
            var end = new Date.getTime();
        }while( end - start >= time)
        console.log( time );
    }
    setTimeout( _ => {
        console.log('开始');
        document.body.style.background = 'pink';
        setTimeout( _ => {
            task(5000)
        },0)
        task(5000);
        console.log('结束');
    },1000)
    结果：
        1.输出 开始
        2.浏览器空转 5s，输出 5
        3.输出 结束
        4.dom 渲染
        5.浏览器空转 5s，输出 5
    结论：dom 在 macroTask 执行前，执行栈为空时渲染

    3.代码：
    function task (time){
        let start = new Date().getTime();
        do{
            var end = new Date.getTime();
        }while( end - start >= time)
        console.log( time );
    }
    setTimeout( _ => {
        console.log('开始');
        document.body.style.background = 'pink';
        new Promise( (resolve,reject) => {
            setTimeout( _ => {
                resolve('pro');
            } ,5000)
        },0)
        task(5000);
        console.log('结束');
    },1000)
    结果：
        1.输出 开始
        2.浏览器空转 5s，输出 5
        3.输出 结束
        4.dom 渲染
        5.浏览器空转 5s
    结论：dom 在 microTask 执行前，执行栈为空时渲染

***关于 a 标签的妙用
    1.<a href="tel:15594980112">打电话</a> //在手机上点击会直接出发打电话
    2.<a href="mailto:lileo126@126.com">发邮件</a> //点击会直接触发发邮件


    
