
function a(x1,x2,x3=0)   里面的形参可以赋值，也可以只用两个值运算  例如 a(2,3);
this 的几种用法
自定义属性    例如  a.xxxx    xxxx为自己编辑  随便都行哈
函数里面声明的全局变量   只有在函数调用的时候才会声明成功




document  对象  的问题



闭包

在函数内部定义一个函数
并且在外部调用函数内部定义的那个函数所构成的闭环。

称为闭包




a[i].onclick = function(){
	a[i] = 1;
}
这种情况是在点击a[i]的时候才调用函数，而函数里面的i是不断变化的，所以得用this



for(var i=0;i<10; i++){
	a[i].onclick = (function(x){

	})
}


query获取的是静态的

所有通过setattribute（添加元素）写的只能用getattribute获取

offsettop  这些只能获取值，不能直接给他赋值。这些是根据父元素，不是根据窗口


document.documentElement.clientHeight   可视窗口的高度
document.documentElement.scrollHeight   整体高度
document.documentElement.scrollTop      滚动条从上往下的偏移量 

事件是可以被 JavaScript 侦测到的行为。




a[i].style.width  取的是行间样式，如果没定义行间样式，就不行。


Math.min()   求最小值
Math.min.apply(null, arr)  获取数组的最值
Math.min(...[v1, v2...])   获取数组的最值


function getMaxOfArray(numArray) {
    return Math.max.apply(null, numArray);
}


onscroll事件    滚动条一动就会发生
document.onscroll = function(){
	
}


Unexpected token   语法错误
window.onscroll   滚轮动的时候
window.onresize   窗口改变的时候
reload() 这个函数相当于把整个页面刷新一次
  

getComputedStyle()是获取当前元素所有的最终使用的 CSS 属性的办法   除过IE
currentStyle()   IE


addEventListener
DOM  只有0级和2级。
Dom 0级会重复
Dom 2级写多个也不会覆盖

	event.cancelBubble = true;//阻止冒泡
	event.preventDefault();//阻止系统事件
	document.removeEventListener('mousemove',snake);//清除事件的函数。

在事件里mouseover是冒泡    mouseenter是事件捕捉

background-orign  背景图根据什么定位

移动端的点击用  touch事件。

事件捕获
当你使用事件捕获时，父级元素先触发，子级元素后触发，即div先触发，p后触发。

事件冒泡
当你使用事件冒泡时，子级元素先触发，父级元素后触发，即p先触发，div后触发。

清除所有的定时器：
var a = setInterval(function(){},100); a是所有定时器的数量，谷歌从1开始计算，火狐从2开始计算。
function clear(){
	var a = setInterval(function(){},100);
	for(var i=0; i<a; i++){
	clearInterval(i);
	}
}
   


键盘事件：
keyCode 是看是哪个键位所代表的数字。（键码值）
String.fromCharCode() 直接是键盘上的东西

表单事件：
onfocus（）获取焦点触发。
onblur（）失去焦点触发。 
onchange（）内容改变且失去焦点触发
oninput（） 只要内容有变化，就会触发。


location.href拿到地址栏的所有东西。


//for in 循环   可以做数组活着对象的循环。
for(var i in x){    x为数组或者对象
	x[i] 
}


用递归函数去除重叠的盒子  遇到的问题：
中间还没有生成盒子时获取不了他的offset那些



 // 把js对象 数组 转化为 JSON格式的字符串
    var result = JSON.stringify(jsArr);

 // 字符串转化为 对象
    var jsArr = JSON.parse(jsonString);

keypress键盘事件，返回ascll码


// 递归函数导致里面不能给每个盒子设置定时器  和 classname、


1.存储大小：cookie 5KB，localstorage 5M
2.生命周期：cookie到本次浏览器会话结束，localstorage不手动删除则永远存在
3.数据类型：cookie存储字符串类型，localstorage存储对象类型
4.兼容问题：cookie全兼容，localstorage兼容ie8以上


location 方法： 
href 整体
host 主机加端口号
hostname 主机
port 端口号
protocol 协议
pathname 路径
hash 片段标识符，用于保存网页状态
search 返回问号后的字段


localStorage的优势
1、localStorage拓展了cookie的4K限制
2、localStorage会可以将第一次请求的数据直接存储到本地，这个相当于一个5M大小的针对于前端页面的数据库，相比于cookie可以节约带宽，但是这个却是只有在高版本的浏览器中才支持的
localStorage的局限
1、浏览器的大小不统一，并且在IE8以上的IE版本才支持localStorage这个属性
2、目前所有的浏览器中都会把localStorage的值类型限定为string类型，这个在对我们日常比较常见的JSON对象类型需要一些转
3、localStorage在浏览器的隐私模式下面是不可读取的
4、localStorage本质上是对字符串的读取，如果存储内容多的话会消耗内存空间，会导致页面变卡
5、localStorage不能被爬虫抓取到
localStorage与sessionStorage的唯一一点区别就是localStorage属于永久性存储，而sessionStorage属于当会话结束的时候，sessionStorage中的键值对会被清空

clear	清空localStorage上存储的数据
getItem	读取数据
hasOwnProperty	检查localStorage上是否保存了变量x，需要传入x
key	读取第i个数据的名字或称为键值(从0开始计数)
length	localStorage存储变量的个数
propertyIsEnumerable	用来检测属性是否属于某个对象的
removeItem	删除某个具体变量
toLocaleString	将（数组）转为本地字符串
localStorage.setItem("name","caibin") //存储名字为name值为caibin的变量


table index 这个属性 再用.focus可自动换input框
.onfocus是当获得焦点的时候
.focus 是直接让其获得焦点   


( function(){…} )()和( function (){…} () ),这两种是自执行函数的两种常见写法



jquery 2.0以后不支持ie 6 7 8 9 。   $就代表jQuery。
jQuery的功能：
1.HTML元素的操作
2.CSS 的操作
3.HTML 事件函数
4.JavaScript 特效和动画
5. HTML DOM遍历和修改
6.ajax

Query的方法:
这里面没有以前js 的那些属性，全是函数，没有原来js的等号
.val() 就是获取input的内容。
$('<div class="sss"></div>') 创建盒子
text()      相当于innerText,如果函数中没参数，是获取文本内容，如果有参数，是替换元素的文本内容。
html()      相当于innerHTML，如果函数中没参数，是获取里面所有html节点，如果有参数，是替换。
append()    在元素尾部追加一个节点。
prepend()    在元素中开头插入一个节点。
before（）    元素前面加一个节点
after（）    元素后面加一个节点
remove()    删除被选及其子元素。
empty（）    删除被选元素的子节点
attr('id','big') 添加一个属性
removeAttr('id','big')  移除属性
addClass()  向被选元素添加一个或多个类
removeClass（） 从被选元素中删除一个或多个类。
toggleClass()   先点击追加一个class，再点击删除刚才添加的class名字
css('width'，'')   可以获取css样式，如果逗号后面写东西，就是修改。
css({'color':'black','width':'100px'})  是以对象的形式修改
width()   元素宽度，不包含内边框和外边框
innerWidth()   元素宽度，包含内边框和外边框 W大写
hover() 相当于以前的hover效果   


$('.big').
也可以用变量存储  var a = $('<div class="sss"></div>')； 变量相当于一个容器，就是放东西用的

回调函数：
function b(){

}
function a(b){
	console.log('ssss');
	b();
}

这个相当于一个回调函数，在a函数执行他的操作完了之后，再去调用b函数

time= new Date()    获取系统时间，
time.getTime();   时间戳，从1970年1月1日 到现在的毫秒数
time.getDate();   获取的是几号
time.getDay();    获取的是星期几   从0开始计数
time.getFullYear()   年      从0开始计数
time.getHours()   小时，24制


* indexeDB:
1.键值对存储
  采用的 对象仓库（object store）存放，所有类型的数据都可以直接存储
2.异步操作
  用户依然可以进行其他操作
3.支持事务
  indexeDB支持事务（transction），意味着一系列操作步骤中，只要有一步失败，整个事务都取消，数据库回滚到事务发生前的状态。
4.同源限制
  indeeDB 受同源策略限制（同域名 同端口 同协议）
5.存储空间大
  比localStorage大得多，一般来说不小于250mb，甚至有些浏览器没有上限
6.支持二进制数据存储
  不仅可以存储字符串，还可以存储二进制数据。
7.indeeDB是一个比较复杂的 api接口
数据库 IDBDatabase 对象
对象仓库 IDBObjectStore 对象
索引 IDBIndex 对象 ,是为了加速数据的检索，可以再对象仓库里，为不同的属性建立索引
事务 IDBTransaction 对象 ，数据记录的增删改查，都要通过事务完成，事务对象提供 error，abort，complate 三个事件。
操作请求 IDBRequest 对象

创建对象仓库：
在数据库更新的时候更新数据。

 var request = window.indexedDB.open('b',2); //2是版本号
    open(dbName,dbVersion)
    dbName:string
    dbVersion:number
    request.onerror 打开数据库失败的函数
    request.onsuccess 数据库打开成功的函数
    request.onupgradeneeded 事件，如果指定的版本号大于数据库的实际版本号，就会发生数据库升级事件 
    request.onblocked   上一次数据库链接还未关闭触发
    request.result.close();  关闭IDBDatabase

    {keyPath:'aa',autoIncrement:true} 
    var a = db.createObjectStore(....)

    创建一个索引来通过name搜索客户
    a.createIndex('name','name',{unique:false})  unique是false可以重复，是true的话不允许重复 
    新增数据：
    function add(date){
      var db = request.result;  通过IDBdatabase来创建事务
      var transaction_obj = db.transaction(['s'],'readwrite');  事务对象
      var obj_store = transaction_obj。objectStore('s');
      obj_store.add();
    }
    var data = {
      name:'snake',
      age:30,
      phonenum:15594972145,
      qq:850968010,
    }

    调用函数：
    var result = add(data);
    result.onsuccess = function(){
      console.log('成功'); 当事件成功的时候会打印
    }

    mySwiper.slideTo(1, 1000, false);让swiper插件跳转到想要的页面

    GUid  永不会重复的编号
    给订单号设置自增 时间戳+随机数+用户id
    通过用户的id 和各种东西拼接。

    nodejs 是基于Chrome浏览器的 v8引擎 的javascript解释器  也叫做JavaScript的运行平台
            node -v   检查文件是否安装成功       
            npm -v    检查文件是否安装成功 
            npm 是包管理
              npm install  jquery    后面跟东西是安装
                    -global  是全局安装
              npm uninstall jquery   这个是卸载
              ctrl c 两次是退出编译环境

    安装步骤
            1.新建 express文件夹
            2. npm install express -g
            3. npm install express-generator -g    应用骨架生成器
            4. express project

    es6
      es和JavaScript的关系
      babel转换器

    let 只在当前代码快内有效
    node x.js   直接就运行出来结果 node只做js的编译
    
    babel 转码器（转换器）  直接 npm install babel -g 全局环境安装

      .babelrc 文件里面
              直接{
                "parents":[],
                "plugins":[],
              }
    语言提案的审批流程
        0.展示阶段
        1.开始征求意见
        2.拟定草案 （试用版）
        3.候选人阶段
        4.定案阶段

    babel 转码器的安装
          npm install babel-presets-latest   
          npm install babel-cli 在上面安装之后安装这个

          npm get registry 

          babel example.js --out-file a.js 把这个js文件输出成a.js文件


          步骤
          1.安装babel (npm install -g babel)
          2.安装babel-preset-latest
          3.安装babel-cli
          4.文件配置（在项目根目录下配置.babelrc的文件）
              格式 {
                "presets":['es2015'],
                "plugins":[],
              }
          5. babel example.js --out-file a.js 把这个js文件输出成a.js文件


          let 是声明一个变量 用法类似与var  只是Let只在代码区域有效




npm install X:

会把X包安装到node_modules目录中
不会修改package.json
之后运行npm install命令时，不会自动安装X
npm install X –save:

会把X包安装到node_modules目录中

会在package.json的dependencies属性下添加X

之后运行npm install命令时，会自动安装X到node_modules目录中

之后运行npm install 
–production或者注明NODE_ENV变量值为production时，会自动安装msbuild到node_modules目录中

npm install X –save-dev:

会把X包安装到node_modules目录中

会在package.json的devDependencies属性下添加X

之后运行npm install命令时，会自动安装X到node_modules目录中

之后运行npm install 
–production或者注明NODE_ENV变量值为production时，不会自动安装X到node_modules目录中

使用原则:

运行时需要用到的包使用–save，否则使用–save-dev。


下面是node上传图片的方法，如果有其他方法看 multer 的官网
var multer  = require('multer'); //先引入这个中间件 提前先npm install multer
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads')   //这个是设置文件存储的目录，默认从根路径开始
  },
  filename: function (req, file, cb) {  
    cb(null, file.fieldname + '-' + Date.now()+'.jpg') // 这个是改文件的名字，目前是写死的
  }
})
var upload = multer({ storage: storage })
router.post('/profile', upload.array('avatar',12), function (req, res, next) {//这个avatar是input框的name，12是限制数量
  console.log(req.files) //这个就是能打印出我们存储的文件的那些信息
  // req.file is the `avatar` file
  // req.body will hold the text fields, if there were any
})


对于上传图片，再做个笔记，下面分别是 ajax 和 axios 两种上传图片的方法
1.ajax
  <form  id="snake"  enctype="multipart/form-data">
      <input  multiple  type="file" name="photo">
  </form>
  var formData = new FormData($('#snake')[0]);
  $.ajax({
    type:'post',
    url:'xxx',
    data:formData, 
    processData: false,//用于对data参数进行序列化处理 这里必须false
    contentType: false, //必须
  });

2.axios
  <form  method="post" enctype="multipart/form-data">
      <input ref='upload' multiple @change='sc' type="file" name="photo">
  </form>
      var formData = new FormData();
      for(let i=0;i<this.$refs.upload.files.length;i++){//这个循环是把所有选中的文件信息添加到对象中
        formData.append('photo',this.$refs.upload.files[i]);
      }
      this.$axios.post('/api/home/photos',formData)

//这是第二种上传图片的办法，用了 formidable 中间件
var formidable = require('formidable');
var fs = require('fs');
var path =  require('path');
router.post('/photos', (req, res, next) => {  console.log(222)
  let form = new formidable.IncomingForm()
  form.encoding = 'utf-8' // 编码
  form.keepExtensions = true // 保留扩展名
  form.uploadDir = path.join(__dirname, './../public/images/') //文件存储路径 最后要注意加 '/' 否则会被存在public下
  form.parse(req, (err, fileds ,files) => { // 解析 formData 数据
    if(err) return next(err) 
    console.log(fileds,files);
    let username = fileds.name //用户名 用于修改用户头像路径
    let oldPath = files.file.path //获取文件路径 ~/public/images/<随机生成的文件名>.<扩展名>
    let imgname = files.file.name //前台上传时的文件名 也就是文件原本的名字
    let userImgname = imgname.replace(/[^.]+/, '1.jpg') //把扩展名前的文件名给替换掉
    console.log(username)
    //我这里为了方便存储 统一将文件名改为 <用户名>.jpg
    let newPath = path.join(path.dirname(oldPath), userImgname) 
    fs.rename(oldPath, newPath, (err) => {
      if(err) return next(err)
      // Model.User.updateOne({ name: username },  //更新用户的avatar属性
      //   { avatar: userImgname }, err => {
      //     if(err) return next(err)
      //     res.json({ avatar: userImgname })                     
      //   })
      })
  })
})


盒子里面的文字不换行，多余的变成省略号（样式里面这样写就行了）
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
	    
	  
***es6
	var a = {['yo']:123} 等于 var a = {yo:123}
	var a = 'yoyo' var b = {[a]:123} b就相当于 {yoyo:123}
可以直接用大括号来定义一个作用域
    1.let 声明变量
          1.只在当前的代码块内有效
          2.let声明的变量名称
          3.let声明变量的时候不允许在一个作用域声明多次，不存在变量提升，只要块级作用域内存在let命令，它所声明的变量就“绑定”（binding）这个区域，不再受外部的影响。
          4.let[a,b,c] = [1,2,3];   连续声明变量的方式   也可以let[a,b=2] = [1];  数组是按顺序
            对象的解构
            let{bar,foo} = {foo:'a',bar:'sss'};  对象可以不按照顺序   因为数组是有序的排列集合 对象是无序的
            let obj = {first:'hello',last:'wold'};   let{first:f,last:l} = obj;   f是 hello  l是 world
            字符串的解构
            let[a,b] = "hello";
            函数传入的参数也可以进行解构
    2.块区域
        1.es5的语法中只存在函数作用域和全局作用域
    
    3.常量
        1.常量在声明的时候必须赋值。
        2.常量不能重新赋值。
        3.如果常量定义的是一个数组，可以给数组添加东西，对象也一样，都允许增删改查，但是不允许重新赋值
    4.解构赋值
        es6允许按照一定的模式和顺序，对数组和对象的值进行提取，并且一一对应，对变量进行赋值，被称为解构
    

        let a1 = "yoman";
        let b1 = 400;
        let str = `${a1}阿斯殴斗IQ；骄傲ID及哦啊就是大陆开始觉得尽可能${b1}`;这种是新的拼接方式  这些代码不用格式化


        es6中数组有两种复制方法
            1.浅拷贝，值赋值引用地址
                var arr1 = [1,2,3]; arr2 = arr1;    改变其中的一个，另外一个也会改变
            2.深拷贝，将数组中的每一个元素拷贝到另外一个元素中   改变其中的一个 其他的不会改变
            var arr1 = [1,2,3]; arr2 = Array.from(arr1);  主要是用这个Arrayfrom方法
                                var arr2 = [...arr1];  这个是超级引用拷贝 也可以进行深度拷贝。
            除了 forin 循环 还有一个forof循环
                for in 是遍历数组的索引  
                for of 是遍历数组的元素值
                object.keys(对象)  这个是看对象中的key值是否存在


//es6 箭头函数
        //基本语法
        let c = (e)=>{console.log(e)}
        //如果参数只有一个，则可以省略小括号，若函数体只有一行输出语句的时候，可以省略大括号

        var a = function(...arg){
            console.log(arg);
        }
        a(1,2,5,5,6,3)   //如果这样的花会把所有的参数给打印出来

        //箭头回调函数
        //数组的循环遍历方法
        let arr = [1,2,3,4];
        arr.map((e)=>{
            console.log(e*e);
        });
        //这个map方法会把数组替你遍历

        //es6 对象的简介写法
        var foo = 'asd';
        var baz = {foo};
        var baz = {foo:'asd'}//等同于这个

        //对象方法简写方法  es6
        var o = {
            method(){
                return 'hey';
            }
        }
        //等同于 es5
        var o = {
            method:function(){
                return 'hey';
            }
        }

        //一个日鬼的对象书写方式
        var a = {['yo']:123} // {yo:123}

        var yo = 'ddd'
        var a = {[yo]:123} // {ddd:123}
        
        // ES6规定class只有静态方法没有静态属性。
        node 不支持加载静态的资源





