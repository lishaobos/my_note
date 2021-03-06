# Vue

el就是element 就是需要获取的元素 一定是html中的根容器
data用于数据的存储 是个对象
methods是写我们的方法  在方法里面直接this.name就可以取到上面data里面定义的信息

<a v-bind:href="link">链接</a>  这种数据绑定在前面v-bind 后面属性里面直接写自定义的k值 不用大双括号
<div v-bind:style="{width:wid + '%'}"></div> 这样也可以绑定（当wid是我们设置的属性）
如果是<div class='a' :class='b'></div> 这种也可以，只是dom的优先级更高一点，两个class都会出现

<p v-html="html"></p>  这种就是在标签中直接插入 我们提前定好的标签
在标签里面绑定事件  v-on:事件名="方法名" || @事件名="方法名" 这个方法可以不用写大双括号  因为用了事件绑定，后面的酒杯认为是方法

vue事件 里面event和我们以前一样

下面这些是阻止事件发生的绑定写法 
 例如v-on:click.stop="doThis"会执行doThis方法然后阻止双击事件  
 如果v-on:click.stop=""  就会直接阻止事件

 <!-- 阻止单击事件继续传播 -->
 <a v-on:click.stop="doThis"></a>

 <!-- 提交事件不再重载页面 -->
 <form v-on:submit.prevent="onSubmit"></form>    prevent是阻止默认事件

 <!-- 修饰符可以串联 -->
 <a v-on:click.stop.prevent="doThat"></a>

 <!-- 只有修饰符 -->
 <form v-on:submit.prevent></form>

 <!-- 添加事件监听器时使用事件捕获模式 -->
 <!-- 即元素自身触发的事件先在此处理，然后才交由内部元素进行处理 -->
 <div v-on:click.capture="doThis">...</div>

 <!-- 点击事件将只会触发一次 -->
 <a v-on:click.once="doThis"></a>

 <!-- 只当在 event.target 是当前元素自身时触发处理函数 -->
 <!-- 即事件不是从内部元素触发的 -->
 <div v-on:click.self="doThat">...</div>
 使用修饰符时，顺序很重要；相应的代码会以同样的顺序产生。因此，用 v-on:click.prevent.self 会阻止所有的点击，
 而 v-on:click.self.prevent 只会阻止对元素自身的点击。


这个是键盘修饰符 可以链式操作
 <!-- 只有在 `keyCode` 是 13 时调用 `vm.submit()` -->
 <input v-on:keyup.13="submit">

 <!-- 只有在 `keyCode` 是 13+14 时调用 `vm.submit()` -->
 <input v-on:keyup.13.14="submit">
   

#  双向数据绑定  v-model  ref
    一般双向绑定都是对于这些个input  里面如果用 v-model绑定哪个属性，vue会自动监视输入框的内容并且改变相应的属性值
    <input v-model="name" type="text"><span >{{ name }}</span>

    如果在input里面写 ref="自定义" 在vue对象里面 比如我们有一个方法 里面 this.$refs.自定义.value 就能获取input里面的当前内容

若我们有一个a属性为1 然后有个盒子 v-on:click="a++" 这样同样会让vue里面的a属性变化

# methods computed watch 区别
# methods里面只要有数据改变就会立即触发这个函数，哪怕内容没变也会再次执行函数
computed利用了缓存,并且里面全是计算属性，不是方法

computed是计算属性，methods是方法，都可以实现对 data 中的数据加工后再输出。
不同的是 computed 计算属性是基于它们的依赖进行缓存的。计算属性 computed 只有在它的相关依赖发生改变时才会重新求值。
这就意味着只要data 中的数据 message 还没有发生改变，多次访问 reversedMessage（对message 进行加工的处理函数）
 计算属性会立即返回之前的计算结果，而不必再次执行函数。而对于method ，只要发生重新渲染，method 调用总会执行该函数。

也就是说，computed 对于其中变量的依赖是多个的，它的函数中使用了多个 this.xxx ,只要其中一个发生了变化，
都会触发这个函数。而 watch 的依赖则是单个的，它每次只可以对一个变量进行监控。 （此处为本人个人理解，可能有错误，后续将改进）

# 绑定class   
大括号里k是class名字 对应的值如果是true就会显示这个class 反之没有   
<div  v-bind:class="{ red:true ,green:false }"></div>
下面这红写法可以把k对应的 值换成在vue里面定义的属性 然后动态的修改他
<div @click="flag = !flag" v-bind:class="{ red:flag ,green:!flag }"></div>
** 可通过计算属性 返回一个对象 假设我们计算属性定义为 yo
例如返回 return {red:flag ,green:!flag}  
<div @click="flag = !flag" v-bind:class="yo"></div>  div里面这样写由上面同样的效果

#  if 和 show 和 for
v-if="条件"  
v-show="条件"  
这两个条件和我们平常写if条件一样，并且得绑定在元素身上
前者是满足了dom中才存在这个元素，后者是dom中存在，他帮你display

for 循环
这个按顺序 值，key，索引
<li v-for="(val,key,indexxxx) in obj">
    {{val}},{{key}},{{indexxxx}}
</li>
这种不论是数组还是对象都循环的是值
<li v-for="dd in obj">{{ dd }}</li>

如果写一个 <template v-for="******"></template> 这是vue提供的，循环完毕之后不回创建template盒子

methods里面有多个方法，可以再一个方法中用this.其他方法来调用其他的方法
同理 两个vue对象 假设为a 和 b   修改对象或者调用对象或者在一个对象方法中改变另一个对象的属性或方法   都和以前的面向对象是一样的

# 定义组件  组件可以进行n多次的重复使用
<yoman a='xxxxx' ></yoman>  是在文件中这么写，这个a属性使我们自定义的，引号里是我们穿进去的内容
Vue.component('yoman', { yoman是我们自己定义的组件名字
  props:['a'],这样也可以传进来参数
  data: function () {  data必须是一个函数
    return {
      count: 0
    }
  },
  methods:{
      say:funcion(){
          this.count ++ ;
      }
  }
  template: '<button v-on:click="count++">You clicked me {{ count }} times.</button>'   这里面就写我们的东西
})
注:和实例化Vue格式差不多  就多了个组件名字  data变为函数形式，其他剩下的都一样
上面是全剧组件，下面这个是局部，是写在实例化的vue组件里面
components:{# 这里面可以写多个组件
  'abc':{
    porps:['a'],
    template:'<div>xxx</div>'
  }
}
注：也可以在Vue实例中写个比如说数组a，然后页面中 <abc :x='a'></abc> 在组件中就可以接收到这个数组

下面这个是组件的函数方式的定义方式
Vue.component('abc', {# 这个 abc是我们写在页面中的标签
            render: function (createElement) {
                return createElement(
                    'h1',  # 这个是我们实际渲染出来的 <h1></h1>标签
                    [# 这个数组里面可以创建多个，创建出来的都包含在h1里面
                    createElement('div','xxx'),# 这个是简单创建
                        createElement('div', {# 这个是复杂一点的创建
                            attrs: {# 这个是div里面的自定义属性
                                name: 'hong',
                                #  href: '###'
                            },
                            domProps: {
                                innerHTML: 'baz'
                            },
                            on: {# 事件
                                click: this.change
                            },
                            style: {
                                color: 'red',
                                fontSize: '34px'
                            },
                            class: {
                                foo: true,
                                bar: false
                            },
                            directives: [# 这个目前没有搞懂
                                {
                                    name: 'my-custom-directive',
                                    value: '2',
                                    expression: '1 + 1',
                                    arg: 'foo',
                                    modifiers: {
                                        bar: true
                                    }
                                }
                            ],
                        })
                    ]
                )
            },
            methods: {# 这个是方法
                change() {
                    console.log(11111);
                }
            }
            props: {# 这个可以接收传进来的参数
                level: {
                    type: Number,
                    required: true
                }
            }
        })


# 脚手架的搭建  Vue cli
    1.脚手架是通过webpack搭建的开发环境
    2.使用es6语法
    3.会把所有js文件打包压缩为一个js文件
    4.项目内文件在环境中编译，而不是浏览器中
    5.实现页面的自动刷新，一保存就会刷新

    安装方法
    1.npm install -g vue-cli  
    2.vue --version 是看你安装好了没有
    3.vue init webpack 项目名称  (vue init webpack-simple 项目名称)括号里面的是简单版
    4.然后跟着提示弄就ok
    如果现在要安装路由就跟着提示，如果没安装路由以后要安装的时候  npm install vue-router  简单版得自己装路由

    路由的配置：
        假设我们在 main.js 文件中
        1.import VueRouter from 'vue-router';  这个是引入我们安装的路由模块
        2.Vue.use(VueRouter)  这个是挂载我们的路由
        3.const routes = [ {path:'/',component:xx} ] 这个xx是我们引入到 main.js文件中的组件模块 
            在数组最后如果写 {path:'*',redirect:'/'} 前面写的所有路径都不满足，*代表全部，然后咱们给跳到 '/'目录
        4.const router = new VueRouter({ 实例化一个路由
            routes,
            mode:'history'  这个是去掉前面的#号
        })
        5.在下面 new的 Vue里面直接把 第四步生成的这个路由对象写进去就行了。
        ***注意 这5步变量名字都得按照这个，不可以自己写自己想写的变量名字

        点击事件里面   this.$router.go(-1)    跳转到上一次访问的网页
                        this.$router.replace('/snake');  跳转到自定义的路由
                        this.$router.push('/snake');  跳转到自定义的路由
    对于路由：
        我们第三步里面对象 {path:'/admin',name:'yo',redirect:'/a1/a1-1'} 
        这里面当我们选中 /admin路径，对应此路由里面 router-view 里面会渲染redirect路由 '/a1/a1-1' 对应组件的视图
        如果我们定义了name 那么跳转链接得写成 <router-link :to="{name:'yo'}"></router-link>

        二级路由还是在main.js中引入然后是属于哪个路由，在那个路由对象加 children数组
            例如：{path:'/about',component:about,redirect:'/a1',children:[
                                    {path:'/a1',name:'a1',component:a1},
                                    {path:'/a2',name:'a2',component:a2},
                                    ]},
        三级路由同理

    路由的复用：
        1.假设在app.vue  写了一个标签 <router-view name="a1"></router-view> 这个name就是我们给路由起的名字
        2.在main.js  {path:'/home',components:{default:home,'a1':a1}}, component就得加s 并且变成对象
                    这个 default意思是默认显示home组件  'a1':a1 这个就得和我们router标签里面name对应


    a标签会刷新页面，我们用vue提供的一个标签就不会发生跳转   <router-link to="#" ></router-link>  这个标签里面 tag="div" 这个属性可以把自己变成我们要的标签 
    <router-view></router-view> 这个标签写在我们的根组件内 就会产生我们使用哪个路由，页面就会显示我们哪个路由里面呈现的内容
    
*** $route对象
   该对象可以监听页面路由的变化，$route.match可以得到路由元的数组信息

进入我们搭建的项目里面  index.html -> main.js(先调用根组件) -> App.vue 然后再调用其它小组件，这是大概顺序
App.vue是我们的根组件  组件里面包含 1.模板 2.行为  3.样式

在组件中 在style标签里面加 scoped属性就会生成每个自己的css作用域名

父组件像子组件传递参数
    1.给子组件绑定一个自定义属性
    2.子组件接收 
        方法：1. props:['自定义属性']
              2. props:{  这个是标准模式
                  自定义属性:{

                  }
              }
子向父传递参数
    1.给子组件写一个方法 里面写 this.$emit('snake','xxxxx');第一个参数是自定义事件名称，第二个是传过去的参数
    2.在父组件找到传参的子组件 在标签上面写 v-on:snake="yo($event)"  yo是我们在父组件中定义的函数 $event是系统提供的接收参数的变量
    3.在父组件的 yo函数中就能拿到传过来的参数  我们就可以传给其他小组件或者为自己所用

监听组件的生命周期
```
// 监听自己的生命周期钩子
this.$on('hook:destoryed', () => {
    console.log(123)
})

// 监听子组件的生命周期钩子
<child @hook:created='fnc' />
```

只要我们vue对象数据变化 我们template就会重新渲染  如果我们之前在模板里  {{ yo }} 这样执行了方法，那么他就会再次执行
如果我们 yo方法里面改变了data里的东西  就会不断执行 yo 函数   所以得注意


对于路由，传参的方式
比如 {path:'/xx',component:aaa,props:{name:'红',pw:123}} 路由是这样定义的
在组件中 props:['name','pw']  这个和组件传参是不一样的，这个得分开


vue的生命周期函数：也竟是我们说的钩子函数
    1.beforeCreate   组件实例化之前执行的函数
    2.created  组件实例，data有了，但是 el还没有，页面还没有渲染
    3.beforMount  组件挂载前，vue实例 data和el都有了，虚拟dom已经配置
    4.mount  组件挂载后，页面显示
    5.beforUpdate  组件更新前，页面未更新，虚拟dom已经配置
    6.updated  组件更新后，页面显示
    _.activated keep-alive 组件激活时调用 # 使用keep-alive组件有效
    _.deactivated keep-alive 组件停用时调用  # 使用keep-alive组件有效
    7.beforeDestory  组件销毁前
    8.destoryed  组件销毁时


守卫:
# 全局守卫
#  router.beforeEach((to,from,next) => {  to是去的路由对象  from是从哪个路由对象来   next是方法  
#    if(to.path != '/login' && to.path != '/register'){
#      alert('请先登录');
#      next('/login');
#    }else{
#      next();         next('/admin')如果括号里面写东西，会跳到写的路径，不写会跳到点击的路径
#    }
#  } );

# 后置钩子
#  router.afterEach((to, from) => {
#    alert(1);
#  })

# 路由独享的守卫
#  const router = new VueRouter({    写在我们的路由中
#    routes: [
#      {
#        path: '/foo',
#        component: Foo,
#        beforeEnter: (to, from, next) => { 
#          #  ...
#        }
#      }
#    ]
#  })


# 组件中的守卫
const Foo = {
  template: `...`,
  beforeRouteEnter (to, from, next) {
    #  在渲染该组件的对应路由被 confirm 前调用
    #  不！能！获取组件实例 `this`
    #  因为当守卫执行前，组件实例还没被创建
  },
  beforeRouteUpdate (to, from, next) {
    #  在当前路由改变，但是该组件被复用时调用
    #  举例来说，对于一个带有动态参数的路径 /foo/:id，在 /foo/1 和 /foo/2 之间跳转的时候，
    #  由于会渲染同样的 Foo 组件，因此组件实例会被复用。而这个钩子就会在这个情况下被调用。
    #  可以访问组件实例 `this`
  },
  beforeRouteLeave (to, from, next) {
    #  导航离开该组件的对应路由时调用
    #  可以访问组件实例 `this`
  }
}

beforeRouteEnter (to, from, next) {   这个得通过next里回调 
  next(vm => {
    vm.name                           vm就是我们的this
  })
}

beforeRouteUpdate (to, from, next) {  这个不用回调，直接能用this  而且他不支持回调
  #  just use `this`
  this.name = to.params.name
  next()
}

beforeRouteLeave (to, from , next) {  这个离开守卫通常用来禁止用户在还未保存修改前突然离开。该导航可以通过 next(false) 来取消。
  const answer = window.confirm('Do you really want to leave? you have unsaved changes!')
  if (answer) {
    next()
  } else {
    next(false)
  }
}

# vue 脚手架3.0版本的安装    vue -V 是看我们当前的版本   vue -h 是查看帮助     npm run serve  这个是开启服务器
  npm install -g @vue/cli   这个是安装
  vue create 项目名称
  以前我们装插件 npm install jquery     现在3.0   npm add jquery   前面那个install也可以
  vue serve snake.vue  假设snake.vue在项目根路径，这个命令就是单独运行一个组件
  vue ui  这个是可视化界面操作  好用
  npm run serve  编译和热更新，用于开发环境
  npm run build  编译并压缩，用于生产环境   这个执行之后会有一个dist文件夹，这就是我们打包好的项目


# 自定义指令
我们只要在任意标签绑定    
例如：<div v-fuck=" 'yo man' " ></div>   也可以这样写  <div v-fuck:xxx=" 'yo man' " ></div>  里面可以传对象，数组，字符串，函数不行
上面的fuck使我们自定义钩子名称

然后在main.js里面写
Vue.directive('fuck', {  这个我们的第一个参数就是我们自定义的钩子名称
  bind: function (el, binding, vnode) {
        这里面el是我们绑定钩子的标签元素
        binding是我们传过来的对象  里面好多东西，其中就包含我们传过来的数据
        最后一个是 vue编译生成的虚拟节点，目前不知道有什么用处
  }
})
这个是局部的
directives: {
  snake: {
    #  指令的定义  (这个bind也可以变成其他的)
    bind: function (el) {
      el.focus()
    }
  }
}
bind：只调用一次，指令第一次绑定到元素时调用。在这里可以进行一次性的初始化设置。
inserted：被绑定元素插入父节点时调用 (仅保证父节点存在，但不一定已被插入文档中)。
update：所在组件的 VNode 更新时调用，但是可能发生在其子 VNode 更新之前。指令的值可能发生了改变，也可能没有。但是你可以通过比较更新前后的值来忽略不必要的模板更新 (详细的钩子函数参数见下)。


# 过滤器
<!-- 在双花括号中 --> 第二个是我们自己定义的

{{ message | snake }}  
<!-- 在 `v-bind` 中 -->
<div v-bind:id="rawId | formatId"></div>

你可以在一个组件的选项中定义本地的过滤器：

filters: {
  snake: function (value) {
    return value.charAt(0).toUpperCase() + value.slice(1)
  }
}
或者在创建 Vue 实例之前全局定义过滤器：

Vue.filter('snake', function (value) {
  return value.charAt(0).toUpperCase() + value.slice(1)
})

还有一种
# 这个this.mes是我们的数据，是一个数组里面包含若干个对象
this.mes.filter(function(m){
# 这个传进来的m是过滤器传进来的mes中所有的数据，是多条 {name: '向着光亮那方',author: '刘同'}这种数据
    if(m.author.match(value)){
        return m.author.match(value); 这个是把m中多条信息只要满足 author匹配 value(传进来的字符串) 全部返回出去
    }
    if(m.name.match(value)){
        return m.name.match(value);
    }
});

****每个组件都必须被一个东西所包裹，



#  module.exports和exports是属于CommonJS模块规范！（exports需要键名）
#  export和export default是属于ES6语法（不清楚ES6?大神请这边逛一逛ES6模块）！
#  同样import和require分别属于ES6和CommonJS！
#  module.exports导出对应require导入，export导出对应import导入。
#  CommonJS规范规定，每个模块内部，module变量代表当前模块。这个变量是一个对象，
#  它的exports属性（即module.exports）是对外的接口。加载某个模块，其实是加载该模块的module.exports属性。

#  Node里面的模块系统遵循的是CommonJS规范。
#  那问题又来了，什么是CommonJS规范呢？
#  由于js以前比较混乱，各写各的代码，没有一个模块的概念，而这个规范出来其实就是对模块的一个定义。
#  CommonJS定义的模块分为: 模块标识(module)、模块定义(exports) 、模块引用(require)

#  export与export default均可用于导出常量、函数、文件、模块等
#  在一个文件或模块中，export、import可以有多个，export default仅有一个
#  通过export方式导出，在导入时要加{ } 这个大括号可以写多个,export default则不需要
#  export能直接导出变量表达式，export 
续：
#  假设我在 a.js export default 'haha'
   在其他页面中的引用方法（下面是针对 导出default 不是单纯的 export）
      1.import snake from './a.js'
      2.import defaultExport from './a.js' # 这个是导出 default 默认模块
      3.import {default as snake} from './a,js' # 这个有一丝日鬼
      4.export {default as snake} from './a,js' # 这个可以直接引入并且导出
# 假设在main.js 
  1.import './a.css' # 这个也可以直接引入css
  2.import ('./a.css') # 这个也ok
  3.let module = await import ('./a.css') # 支持 await
  4.import ('./a.css').then(_ => { # 支持then
    do something
  })

写一个 export 导出函数的感觉
1.在接口文件导出
export  let snake = async () => {
  let a = await axios.post(...); 
  return a;# 这个 return会等到上面 await 的函数执行完毕
} 
2.在页面中引用
import {snake} from 'xxx';
直接在页面就可以 snake()函数执行 



哈哥精讲
Vue 是构建web界面的库，一般适用于单页应用，他提供了MVVM数据绑定和一个可以组合的组件系统,是双向数据库绑定
双括号里面支持三目运算方法，里面页可以运算

单页应用：SPA
    单文件组件  a.vue这样一个文件就是组件，一个页面的构成通过组件来构成
多页应用：


cdn和本地银土的比较，开发是推荐使用本地引入（加载速度快不受网络限制），生产环境（上线的时候推荐使用cdn，减少自己的服务器的压力）

MVC
model（模型->数据源）  view（视图层） controller（控制器->逻辑层）

MVVM
model（模型->数据源）  view（视图层） virtualModel(虚拟的model层)


双括号里面是声明式渲染，v-html和v-text等等这些是指令渲染
指令渲染和声明渲染的区别：
    1.当没有vue的时候，声明式的渲染会将双括号表达式汲取内容进行渲染，而指令渲染不会对元素进行任何的渲染
    2.当指令渲染和生命渲染同时存在的时候，指令渲染会覆盖声明渲染
    3.bind指令是为当前有自定义属性进行绑定
再次注意：computed是计算属性，调用的时候不能带括号，如果里面的值没有改变那么就会利用缓存返回上一次计算过的值
         适用于频繁的或者复杂的运算，methods中的方法每次都要计算，所以computed的执行效率就比较高

v-model.trim.number='num'  这个就可以把空格和类型转换成数字类型。(v-model也可以加修饰符)

监听属性
watch属性是用来监听vue对象属性值的变化，一旦发生变化，就会调用绑定的函数
watch(){

}
在watch里面写和属性里面名字一样的函数，如果这个数据有改变，就会触发这个函数，这个如果写两个形参，系统会传过来两个数据
这两个参数一个是改变之前的值，一个是改变之后的值。
这个属性比较消耗内存，所以还是少用。

关于插槽的几种方式
首先我们创建了一个snake的组件  里面template:'<div></div>'
1.普通
  我们在页面中 <snake>你好</snake> 里面的内容是不会显示出来的
  我们可以把模板变成 template:'<div> <slot></solt> </div>',这样会显示，
但是如果我们写了好几个 slot页面就会重复出现几次 你好,因为这个slot是默认的出口

2.定义属性
  如果我们 <snake> <h1 slot="fuck">我不好<h1> </snake> 在页面中这样写
  然后在模板中只要 slot这样写 <slot name="fuck"><slot>这样就会出现我们相对应
  的内容，当然我们这个里面可以写多个这种自定义的

3.作用域
  假如我们模板中 <div> <slot con="yo man"></solt> </div>
  在页面中我们  <snake> <div slot-scope="props"> {{props.con}} <div> </snake>
  这样也会出现我们的内容，这个props是自定义的，啥都行


关于vue里面怎么引入一些其他的比如 layui 的组件
script脚本在 index.html 里面引入，实例组件的那些方法写在 mounted 函数里面
外部的 css 样式可以在组件的 style 里面  import './sss.css';


路由的再深入：
    { path: '/a', redirect: '/b' }
    { path: '/a', redirect: { name: 'foo' }}
    上面这两种 都是重新定向路径
    { path: '/a', component: A, alias: '/b' } 这个是给路径起一个别名，访问两个都是一样的

滚动行为
const router = new VueRouter({# 在实例化路由的时候 scrollBehavior 这个方法可以让滚动条跳到想要的位置
  routes: [...],
  scrollBehavior (to, from, savedPosition) {
    #  return 期望滚动到哪个的位置
  }
})
scrollBehavior (to, from, savedPosition) {
  if (to.hash) {# 这个比如说 <router-link to="/index#a" /> 这个to.hash就可以取到#a,然后我们可以判断
    return {
      return { x: 0, y: 0 }
    }
  }
}
scrollBehavior (to, from, savedPosition) {
  if (savedPosition) {
    return savedPosition
  } else { # 这个就是返回一个位置的坐标，改变滚动条的位置
    return { x: 0, y: 0 }
  }
}

  动态路由 $route是挂载在我们vue实例下的路由实例
  { path: '/user/:id', component: User}
  这个：id使我们自定义的，他可以是变化的，都对应的是 User组件
  {{ $route.params.id }} 就可以取到我们 ：id 真实的所对应的路径
  $route.query可以取到我们如果路径后面还有？xxxxx 可以取到我们路径后面的值
  $route.hash 可以取到我们的 hash值


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
    processData: false,# 用于对data参数进行序列化处理 这里必须false
    contentType: false, # 必须
  });

2.axios
  <form  method="post" enctype="multipart/form-data">
      <input ref='upload' multiple @change='sc' type="file" name="photo">
  </form>
      var formData = new FormData();
      for(let i=0;i<this.$refs.upload.files.length;i++){# 这个循环是把所有选中的文件信息添加到对象中
        formData.append('photo',this.$refs.upload.files[i]);
      }
      this.$axios.post('/api/home/photos',formData)

对于动态组件
<component :is="view"></component> 这个 view 就是我们的组件的名字
components:{
        a:{
            template:'<div> <input type="text"> </div>'
        },
        b:{
            template:'<div> 我是b </div>'
        }
    }
可以设置点击事件 让 view 变量变成 a 或者 b,这样就可以起到切换组件的效果

下面是 keep-alive 的用法
<!-- 基本 -->    
<keep-alive>
  <component :is="view"></component>
</keep-alive>

<transition>  这个就是稍微有个缓冲的效果
  <keep-alive>
    <component :is="view"></component>
  </keep-alive>
</transition>

下面这三个就是定义有哪些组件可以被缓存，不满足的就不会被缓存
<!-- 逗号分隔字符串 -->
<keep-alive include="a,b">
  <component :is="view"></component>
</keep-alive>

<!-- 正则表达式 (使用 `v-bind`) -->
<keep-alive :include="/a|b/">
  <component :is="view"></component>
</keep-alive>

<!-- 数组 (使用 `v-bind`) -->
<keep-alive :include="['a', 'b']">
  <component :is="view"></component>
</keep-alive>

***关于 keep-alive再补一些知识
   1.activated 和 deactivated 这两个生命周期函数只有在 keep-alive 组件中的才会触发
   2.include 和 exclude 这俩就不多说了，但项目中出现无法生效的问题
   3.关于缓存部分路由跳转的组件
      1.在路由中加上 mete对象 keepAlive 属性为 true
      2. <keep-alive>
         <router-view v-if="$route.meta.keepAlive"></router-view>
         </keep-alive>
         <router-view v-if="!$route.meta.keepAlive"></router-view>
      3. beforeRouteLeave(to, from, next) {
         to.meta.keepAlive = true;  #  修改缓存属性
         next();
         }


对于 vue 中 只要 npm i -S less less-loader    (把 less 和 less-loader 两个一装)
然后 style标签上 lang='less' 就ok


对于 vuex （这个是vue状态管理，可以管理全局的状态）,在组件方法或者记算属性中，this.$store.state就可以操作我们仓库的state对象，其他道理是一样的
const store = new Vuex.Store({
  state:{ # 这个里面相当于组件的 data 属性,里面放着所有的数据
    todos: [
      { id: 1, text: '...', done: true },
      { id: 2, text: '...', done: false }
    ]
  },
  getters:{
    doneTodos: (state,getter) => {# 这里面系统穿件来两个参数，第一个是上面的 state 在一个就是 getter 自身，相当于组件的 computed属性
      return state.todos.filter(todo => todo.done)
    }
  },
  # mutaions里面必须是同步函数 this.$store.commit('xxx')可以触发
  mutaions:{
    increment (state, payload) {# 第一个是咱们的 state对象，第二个是自己穿进去的形参
    state.count += payload.amount
  }
  },
  # 里面可以是异步函数，这也是不直接用mutaions里面的原因，这个可以dispatch触发actions里面的方法
  actions:{Action 提交的是 mutation，而不是直接变更状态。Action 可以包含任意异步操作。
    increment (context) {# 这个是传进来的形参
      context.commit('increment') # 这个就可以直接调用我们 mutaion 里面的方法，括号里面是方法字符串
    },
    increment ({ commit }) {# 这个和上面挨着的方法一样，只不过用了对象的解构
    commit('increment')
  }
  },
  modules:{}# 这个暂时不需要知道
})

关于 modules 是时候该知道了
let a = {
  state:{
    name:1
  },
  getters:{
    getMes(state){
      return state.name
    }
  },
  mutations:{
    changeMes(state){
      state.name++
    }
  },
  actions:{
    mes({commit}){
      commit('changeMes');
    }
  }
}
let b = {
  state:{
    name1:'我是b'
  },
  getters:{
    getMes1(state){
      return state.name1
    }
  }
}
# 这个就是我们合成的 状态管理树
let store = new vuex.Store({
  modules:{
    a,b
  }
})

***对于状态管理树的knowlege
假设 store 里面的 modules 里面有很多的模块，如果没有命名空间的话，是会全部映射到全局的，会导致一些冲突
在modules里的对象里（也就是模块）
   1.namespaced:true # 开启命名空间（作用是除了 state 其他都会注册到局部，会根据模块路径命名）
   2.在命名空间里面嵌套的模块会继承命名空间,并且启用了命名空间的 getter 和 action 会收到局部化的 getter，dispatch 和 commit
   3.一些需要注意的点：
      1.getters:{
         fuck(state,getters,rootState,rootGetters){} # 他会额外传入全局的参数和getters
        }
      2.actions:{
         yo({commit,dispatch,rootState,state,getters,rootGetters}){} # 这些全局和局部都可以结构出来，当然不止写的这些
      }
   4.root:true
      假设我们要commit 或者 dispatch 全局的方法，此时我们应该 commit('名字',null,{root:true}) dispatch('名字',null,{root:true})
      在实验过程中，如果局部和全局都有相同的方法名字，那么不影响，还是会用全局的

      要 dispatch 某个模块的方法 #   $store.dispatch('模块名/方法')
   5.关于怎么在组件中引入有命名空间的方法
      1.第一种
         import {mapGetters,mapState} from 'vuex'
         ...mapGetters('模块路径',['方法']) # 假设我们是a模块，模块路径就写 a 就行
         ...mapStates('模块路径',['属性'])
      2.第二种
         import {createNamespacedHelpers} from 'vuex'
         const {mapState:myState,mapGetters:myGetters} = createNamespacedHelpers('模块名') # 注意得用 ：起别名
         ...Getters(['方法'])
         

# 在我们的组件中有两种方法获取信息
  1.第一种
    this.$store 就可以获取我们的信息  
  2.第二种
    1.先 import {mapGetters} from 'vuex'  # 这里先用mapGetters举例，其余的只要引入就行了
    2.在计算属性中
        computed:{
          ...mapGetters(['getMes','getMes1'])  # 这数组里面的字符串就是我们状态树 getters 里面的方法
        }
    3.在页面中 <div> {{ getMes }} </div>  # 这就可以展示信息
注：计算属性里面不能放 mapActions ,这个放在 methods 里面就行了




  对于组件的懒加载，有好几种方式
  1.import（这种方式会把每个组件都分成一个js文件模块）
    component: () => import ('./components/......')
  2.webpack推荐（这种写法最后一个参数，如果有组件一样，那么这两个组件就会打包成一个js文件，如果都不一样，就和第一个方法是一样的）
    component: (resolve) => require.ensure([],() => resolve(require('./components/......')),'xx')
  
  顺便说说全局注册一个组件和局部引用一个组件的区别。
  1.只是命名空间的不同，打包之后的体积是一样的。
  2.不同的情况在于，如果你使用路由的懒加载，然后这个路由的页面中引入了组件，那么虽然打包体积是一样的，但是你只有请求这个路由，这个组件的资源才会被请求过来。

  对于vue 父组件调用子组件的 methods
    例如：<children ref="ccc" /> # 这个是引入的子组件
          然后在父组件中 this.$refs.ccc.yo() 就ok了 yo是子组件的方法
  子组件调用父组件的方法
    在子组件中 this.$parent.father()   father是父组件的方法

  
***关于 Vue 的打包
  1.首先在路由懒加载的时候，我们加入这个注释，不是参数，这个模块就会被打成这个名字的 js 文件，如果有多个是一样的包名，会合并在一起。
    component: () => import(/* webpackChunkName: "aaa" */ './views/aaa.vue')
  2.通过打包发现 Vue 中组件有独立的作用域，都是因为组件全部以函数的形式渲染，所以每个函数有各自的作用域。
  3.上次遇到一个打包问题（一个组件全局注册，局部注册，打包的体积变化）;
    说明：上一步也说了组件打包会变成独立的渲染函数，所以这也是一个命名空间的问题，经过测试发现，如果两个路由页面中引入了一个相同的组件，那么
          打包之后这两个页面都会打包进去这个组件，体积就增大了，然后我又测试全局注册组件，发现只是在全局的包里面打入了这个组件，而这两个页面
          没有打入这个组件，惊呼！

对于 ref 
1.如果绑定的是普通元素
  例：<div ref="yo" />
      this.$refs.yo 指向的就是这个元素
2.如果绑定的是引入的子组件
  例：<zzz ref="yo" />
      this.$refs.yo指向的就是这个子组件本身，我们也可以调用它的方法（this.$refs.yo.method()）
3.关于 ref 注册时间的重要说明
  因为 ref 本身是作为渲染结果被创建的，在初始创建的时候不能访问他们，他们还不存在，$refs也不是响应式的，因此也不能做数据绑定
  **
  有时候我们调用 this.$refs 发现没有拿到想要的数据，所以：
      this.$nextTick( ()=> {
        this.$refs.xxxxx   # 这里我们就可以拿到我们想要的
      })
  **

对于 filter
  例如：
    var arr = [1,2,3];
    arr.filter((a,b,c) => {
      # a参数是数组的每一条数据
      # 下面这种没有if条件，他也可以帮你检索每一条中 大于 2 的，不会改变原来的数组
      return a>2
    })

对于 sort（js提供的数组排序方法）
    例如：
      var arr = [];
      arr.sort((a,b)=>{
        return a-b # 这个 a-b 和 b-a 只是返回的数组排序顺序不一样
      })
    若是数组对象：
      var arr = [{
        num:1
      },
      {
        num:2
      }
      {
        num:-1
      }]
      arr.sort((a,b)=>{
        return a.num - b.num # 这个和上面同理，只是根据数组里面的对象属性排序
      })
      
      
对于一些vue项目中的数组监听和对象监听踩的坑
   1.数组
      Vue中包含一些观察数组的变异方法，他们踩会触发视图更新：push pop shift unshift splice sort reverse
      由于js的限制，Vue对于下面两点变动的数组是检测不到的，也是遇到的坑
         1.vm.items[i] = 123; # 不是响应的，会导致视图不能更新
         2.vm.items.length = 0 # 不是响应的，会导致视图不能更新
       处理办法：
         1.用数组的操作方法
         2.vm.$set(vm.items, i, newValue) 或者 Vue.set(vm.items, ii, newValue)
   2.对象
      例如：
         var vm = new Vue({
            data: {
                  a: 1
               }
            })
         #  vm.a 现在是响应式的
         vm.b = 2 #  vm.b 不是响应式的
       原因：对于已经创建的实例，Vue不能动态的添加根级别的响应式属性，下面是对于嵌套对象添加响应式属性
       处理办法：
         var vm = new Vue({
            data: {
                  ojbk: {
                  }
               }
            })
         0.有时候得处理一些可以被监听的属性，得$set,要不然坑很大
         1.vm.$set(vm.ojbk,'name','fucking shit') # 适用于赋予单个新属性
         2.适用于赋予多个新属性
            vm.ojbk = Object.assign({}, vm.ojbk, {
                  age: 27,
                  name: 'yo man'
            })
   3.一些零碎的记录
      1.watch里面监听不到对象里面某个值的改变
      2.像是一个数组里面有很多个对象，要修改某个对象的属性
         0.vue建议用数组替换原来的数组，这么做是vue推荐的
         1.this.arr[index].showAlert = true; Vue.set(this.arr, index, this.arr[index]); # 对数组
         2.Vue.set(this.arr[index], `showAlert`, true) # 对对象
         3.this.arr[index].showAlert = true; this.arr = Object.assign({}, this.arr); # 这个有点日晷
         4.set的对象的值或者数组的值都会覆盖之前的
            
关于 Vue 的provide
   例子：export default {
            name:'我是爸爸',
            provide(){
               return {
                  yo:this.xxx # data里面的属性，或者函数其他的
               }
            }
         }
         export default {
            name:'我是儿子',
            inject:['yo'] # 这个就是爸爸的东西
         }
         export default {
            name:'我是孙子',
            inject:['yo'] # 这个就是爷爷的东西
         }
     ***总结  
          如果想让孙子组件内保持响应，那么可以传入响应式的对象，比如再父组件 data 里面定义的某个对象

关于 Vue 的 inheritAttrs $attrs $listeners
   1.inheritAttrs
      说明：该属性是默认是 true，如果设置为 false 的话，在父容器中子组件定义的属性，例如：
            # 父组件
            <div>
               <childs sex='1'>
            </div>
           子组件中没有用 props 接收的，在 dom 中是不显示这个 sex 的，默认 dom 上是有的
   2.$attrs
      说明：该属性用于高阶组件，假设我们父组件向孙子组件传参，一般情况下是 props 传递下去，这个展示的是父组件在子组件上定义的参数列表，不包含
            props 里面接受的参数，但是父组件在子组件上定义 v-bind='$attrs' 孙子组件中 props 接受就可以，就不用中间存了，这个可以无限往下传递
   3.$linsteners
      说明：该属性用于高阶组件，和 $attrs 类似，也是不用 $emit 传递事件，只要 v-on='$listeners' 孙子组件直接 emit 就行了
            
关于 Vue 的 extend
   使用基础 Vue 构造器，创建一个“子类”。参数是一个包含组件选项的对象，data 选项是特例，需要注意 - 在 Vue.extend() 中它必须是函数
   1.上面的官网的说法，简单来说：
      1.写一个组件
      2.import demo from './demo' // 这个 demo 是一个有组件选项的对象
      3.let conponents = Vue.extend(demo) // 这个 components 是一个组件的构造函数
      4.let instance = new conponents({
         el: document.create('dev') 
        })
      5.当然第4步也可以 $mont 或者 el 选项提供某个dom 的 id
      6.然后就可以写我们自己的 $alert $confirm 等等，挂载到 Vue 对象上供全局使用 

关于 Vue 的 mixins
   1.mystyle.js
      export {
         methods:{
            aaa(){
               console.log(123)
            }
         }
      }
    2.a.vue (引入然后写在 mixins 属性里面，这就是组件内的混入，不建议全局混入)
      export default{
         mixins:[mystyle]
      }
    3.说明
      1.当组件和混入对象含有同名选项时，这些选项将以恰当的方式进行“合并”,比如，数据对象在内部会进行递归合并，并在发生冲突时以组件数据优先。
      2.同名钩子函数将合并为一个数组，因此都将被调用。另外，混入对象的钩子将在组件自身钩子之前调用。
      3.值为对象的选项，例如 methods、components 和 directives，将被合并为同一个对象。两个对象键名冲突时，取组件对象的键值对。


关于 Vue nextTick
  此方法是在执行栈为空的时候执行，也就是 dom 渲染的时候进行，可拿到渲染之后的 dom
  
关于 Vue 渲染机制
    1.在页面中有一个 methods return 的内容，发现在此页面中改变其他不相干的响应数据，这个 methods 只要在这个模板中，其他数据改变，这个方法都会执行，
      得出结论 Vue 的模块渲染时模块整体渲染的。
    2.在这个页面中引入一个组件，组件中同样有一个 methods return 的内容，然后改变页面中的响应数据，发现组件内的方法不会执行，也就是说组件不会重新渲染
      但是给组件注入一个在改变的数据，发现注入数据改变时，组件内方法会执行，得出结论 Vue 很智能，只要某个组件页面有响应数据改变，都会重新便宜渲染
   
关于 $event
   例：<div @click="yo($event)" /> # 我们就可以接收到原始的 dom 事件
       <div @click="yo(message,$event)" /> # 也可以同时接受我们传进来的参数
       <div @click="a = $event" /> # 用我们的参数来接受也是可以的

关于 vue 打包之后出现的没见过的 link 标签
   例1：<link rel="preload" href="style.css" as="style">
        <link rel="preload" href="main.js" as="script">
        preload 就是浏览器预先加载，且不会发生阻塞， href就是文件地址，as就是告诉浏览器要解析什么类型的资源
   例2：<link rel="preload" href="sintel-short.mp4" as="video" type="video/mp4">
        支持 type 属性，这一属性可以包含该元素所指向资源的MIME类型。在浏览器进行预加载的时候，这个属性值将会非常有用
        ——浏览器将使用type属性来判断它是否支持这一资源，如果浏览器支持这一类型资源的预加载，下载将会开始，否则便对其加以忽略。
        mime 类型用处是在于浏览器会用识别这个类型的默认工具打开
   例3：<link rel="preload" href="bg-image-wide.png" as="image" media="(min-width: 601px)">
        可以加媒体查询
   例4：<link rel="preload" href="fonts/zantroke-webfont.woff2" as="font" type="font/woff2" crossorigin="anonymous">
        字体是一个大问题，因为字体是较晚才能发现的资源，如果资源是跨域的，那么久要加上 crossorigin 属性（字体不跨域也得加）
   例5：<link rel="preload" as="style" href="asyncstyle.css" onload="this.rel='stylesheet'">
        <link rel="preload" as="script" href="async_script.js" onload="var script = document.createElement('script'); script.src = this.href; document.body.appendChild(script);">
        这个基于标签的异步加载方式有点酷
    例6：<link rel='prefetch'>
         这个标签经过测试，是在浏览器闲的时候才加载的资源（比如说加载电子书的下一页的内容）

关于 vue 中引入 node_mudles 里面的文件不需要绝对路径，或者相对路径，只要引入文件夹名称就行
   1.node.js规定了如果引入路径没有 ./ 就会从这个大文件的 node_modules文件夹里面找，如果没有再往上一层 node_modules 文件里面找（这是node的约定）
   2.目前 es6 import 语法都是转译成 require的

关于 vue 中的递归组件，也就是组件调用自身
   1.因为组件中有 name 属性，这个 name 不仅是在报错的时候可以帮助我们快速找到错误组件，还可以调用自身
   2.例如：
      <template>
         <div v-for='item in list'>
         <yo :list='item.list'>
         <div>
      </template>
      export default {
         name:'yo',
         props:{
            list:Array 
         }
      }


***vue.config.js
对于脚手架 cli3 的配置
1.在根目录新建一个 vue.config.js文件
2.里面写 (这个只是配置简易路径,其他的用上了再搜)
let path = require('path')
function resolve (dir) {
  return path.join(__dirname, dir)
}
module.exports = {
  productionSourceMap:false, # 这个是vue打包不产生 map文件，map文件对报错精确到哪里有作用
  # 代理请求
  devServer:{
    proxy:'http:# 111.111:80' # 这种写法是所有请求都会被代理到这个接口
    proxy:{
      '/api':{  
        target:'http:# 111.111:80', # 这个代表所有 /api 开头的请求都被代理到这个地址（可以根据下面的 node 全局环境变量变化）
        changeOrigin:true, # 这个得开启
        pathRewrite:{
          '/api':'' # 这个是api代理请求之后 把 /api 变为空，请求里面就没有 /api 了,
        }
      }
    }
  }
  # 配置路径别名用
  chainWebpack: config => {
    config.resolve.alias
      .set('@', resolve('src/components')) 
  }
}

**关于 Vue 里面自动引入组件的解决办法（这个其实是 webpack 的方法）
   const path = require("path");
   const files = require.context("./components", false, /\.vue$/); # 参数依次是 检索路径，是否检索子集，正则
   const modules = {};
   files.keys().forEach(key => {
     const name = path.basename(key, ".vue"); #  name 就得到了模块名字
     modules[name] = files(key).default || files(key); # 得到模块，可以解构到 components
   });

**关于 vue 配置生产环境或者开发环境时候的问题 
  1.process 对象
    该对象是在 node 环境中一个 global 对象，控制 node 进程，他对于 node 应用程序始终是可用的，所以不需要 require
  2.process.env.NODE_ENV 会是"development"、"production" 或 "test" 中的一个。具体的值取决于应用运行的模式。（axios 可以根据这个来设置 baseUrl）
  3.process.env.BASE_URL 和 publicPath 对应，设置这个就会改变我们部署的基础路径
  4.process.env.VUE_APP_* 还提供了这么个格式的变量，* 是我们能改的东西
  5.新想法：
      请求前缀前部变成 /api ，全部在 nginx 做代理就行了



***关于 axios 
import router from './router/router.js' # 直接引入我们实例化的router
axios.defaults.headers.post['Content-Type']='application/x-www-form-urlencoded'
const httpRequest = axios.create({
    baseURL: '/api/',
    timeout: 50000,
    withCredentials:true,# 携带 cookie 到服务器
    transformRequest: [function (data) {
        #  对 data 进行任意转换处理
        data = qs.stringify(data) # 这个配合上面那个请求头，是为了发过去表单数据格式（form-data数据格式）
        return data;
      }],
});
#  添加请求拦截器
httpRequest.interceptors.request.use(function (config) {
    #  在发送请求之前做些什么
    config.headers.token = Vue.cookie.get('token_') || '' ; # token
    return config;
  }, function (error) {
    #  对请求错误做些什么
    return Promise.reject(error);
});
# 在响应的时候，如果身份验证过期，可以 router.push('/login') # 这个虽然没有挂载到 Vue 上，但是这样是可以使用的



***Vue 深入简出总结

  Vue总的来说可以分为4个阶段
    1.初始化阶段
      1.new Vue
      2.初始化 Event lifecycle
      3.beforeCreate
      4.初始化 injections reacitivity
      5.created
    2.模板编译阶段
      1.是否有el选项，没有使用$mount(el)
      2.是否有temalate选项 ? 3 : 4
      3.通过template选项获取模板
      4.通过el选项获取模板
      5.将模板编译为渲染函数
    3.挂载阶段
      1.beforeMount
      2.创建vm.$el替换el
      3.mounted
    4.已挂载
      1.beforeRouteUpdate
      2.使用虚拟dom重新渲染
      3.update
    4.卸载阶段（当vm.$destory被调用）
      1.beforeDestory
      2.卸载依赖追踪，子组件与事件监听器
      3.destoryed

  数据变化侦测到相应总结：
    1.通过闭包和递归策略，Objet进行递归处理，每一个key使用闭包配合Object.definproperty进行处理，Array不同的一点是建立拦截函数
    2.主要涉及的依赖存储和依赖更新
  
  虚拟dom：
    说明：Vue从原来的细粒度变为中等粒度，变成了以组件为单位观察的策略，减少了很多watcher观测，也就减少了很多内存开销
    1.VNode
      说明：节点描述对象，是一个javascript对象
      类型：
        1.注释节点
        2.文本节点
        3.元素节点
        4.组件节点
        5.函数式组件
        6.克隆节点
      总结：
        由于Vue采用了虚拟dom来更新视图，当属性变化的时候，真个组件都要进行重新渲染的操作，但是组件内并不是所有的dom节点都要进行更新，所以将VNode缓存，并将上一次缓存的oldVNode进行对比，
        只对需要更新的部分进行dom操作也可以提升很高的性能

    2.patch：
      说明：进行新增，删除，更新VNode，目前没看懂算法，是虚拟dom的核心算法
      总结：
        通过patch对比新旧两个虚拟dom，对只需要更新的节点进行更新
  
  模板编译：
    1.解析器
      1.使用正则将模板解析成AST语法树
      2.举例：
        <div>
          <p>{{ name }}</p>
        </div>
        转为AST的样子：
          {
            tag:'div',
            type:1,
            static:false,
            children:[
              {
                tag:'p',
                type:1,
                static:false,
                children:[
                  {
                    type:2,
                    text:'{{ name }}',
                    static:false,
                    expression:'_s(name)'
                  }
                ]
              }
            ]
          }
    2.优化器
      说明：存在一些静态的节点，永远都不需要重新渲染，所有找出来他们，只渲染一次
      1.找出所有的静态节点且标记    
      2.找出所有的静态根节点且标记
    3.代码生成器
      说明：通过AST语法树转为渲染函数的内容，内容也就是代码字符串，通过包装函数执行字符串，也就成了我们的渲染函数
      转化的样子如下：
        _c('div',{ attrs: { id: 'el' }, [ _c('div', [ _c('p') ] ) ] } )
      总结：是一个大数组

    
    组件更新策略：

    说明：
          自从 Vue 更新粒度变成以组件为粒度，每个组件都对应有一个 watcher，在 render 的时候， window.target 置为当前组件，此时组件中每个 vNode 读取数据的时候都会把当前组件的 watcher 增加到依赖中，
          每次更新数据会通知整个组件更新，子组件只会在所依赖的参数更新时才会更新

          子组件更新注意：

            // 父组件 arr 不更新，子组件不会重新更新
            <children :arr='arr' />

            // 父组件数据变更重新渲染，子组件取 arr 每次都是一个新的数组里面包装的依赖，所以子组件会随着父组件更新而更新
            <children :arr='[arr]' />

            // 此情况因为 computed 会缓存结果，所以每次父组件更新，若子组件依赖没更新，子组件就不会更新
            <children :arr='arr_' />
            computed: {
                arr_ () {
                    return [this.arr]
                }
            }
    
    






    
