## KOA

```
1.首先关于跨域
    目前在实验的情况下不支持 cors 需要  koa-cors 这个中间件
        1.npm i koa-cors
        2.在 app.js 中 const cors = require('koa-cors')
        3.app.use(cors()) 这个就是允许任何来源进行跨域访问了
        4.第三步中那些允许访问的来源，或者方法那些和 cors 差不多，只是名字不一样，具体看 koa-cors 官网

2.关于koa的路由（支持动态路由，和vue写法差不多，通过 ctx.params 获取）
    1.npm i koa-router (如果是用骨架生成，会自动安装的)
    2.let router = require('koa-router')(); 这个就是路由了
    3.假设我们 router.get('/yo', async (ctx,next) => {
        ctx.request.query   ctx.request.body   //这两个就是我们 get 或者 post 请求过来的信息
        ctx.body = '我是返回回去的信息'  //这个就是返回数据的方法
    })
    4.module.exports = router //导出我们的路由
    5.在 app.js 中
        1.let index = require('./xxxx') //引入第四步导出的路由模块
        2.app.use(index.routes(),index.allowedMethods())  //这一步我们的路由就已经OK了 注：app不可以使用嵌套路由的写法

3.关于koa的路由嵌套
    1.下面这个就是简单的路由嵌套 (ctx.parmas //获取动态路由)
    var forums = new Router();
    var posts = new Router();
    posts.get('/', (ctx, next) => {...});
    posts.get('/:pid', (ctx, next) => {...});
    forums.use('/forums/:fid/posts', posts.routes(), posts.allowedMethods());

5.关于koa的路由传参
    router.get('user', '/users/:id', (ctx, next) => {
        // ...
    });
 
    router.url('user', 3);
    // => "/users/3"
 
    router.url('user', { id: 3 });
    // => "/users/3"
 
    router.use((ctx, next) => {
        // redirect to named route
        ctx.redirect(ctx.router.url('sign-in'));
    })
 
    router.url('user', { id: 3 }, { query: { limit: 1 } });
    // => "/users/3?limit=1"
 
    router.url('user', { id: 3 }, { query: "limit=1" });
    // => "/users/3?limit=1"


4.关于koa的路由前缀
    1.第一种
    var router = new Router({
    prefix: '/users'
    });
    router.get('/:id', ...); // responds to "/users/:id"
    2.第二种
    router.prefix("/api/customer"); 
    
***关于 koa 中间件的一些处理
    参考网站：https://blog.csdn.net/chaoxiao1231/article/details/82862349
    例：
        1.先随便创建一个中间件文件（我们可以在这里处理一些路由正则验证，或者token的判断）
            let res = async (ctx,next) => {
                console.log(ctx.request.body)
            try{
                next(); //这个next方法的作用就是把执行权交给下一个中间件，next()下面的先暂时不执行
               }      
            catch(err){
                ctx.body = {
                    code:1,
                    mes:'发生错误'
                   }
            }
               if(ctx.body){ //这个就是等后面的中间件执行完之后（假设我们按照请求返回了数据）
                ctx.body = { // 这个返回的对象就是我们处理过的
                     mes:'处理过得数据',
                     data:ctx.body  //这个就是我们后面中间件返回的数据
                    }
                }
            }
            module.exports = res      
        2.在app.js中，在路由模块 use 之前，或者在我们自定义安放的位置 use 我们这个中间件
            例：
                let midware = require(./midware/midware)
                app.use(midware)
                //下面就是我们路由，或者是其他东西
                app.use(router.routes(),router.allowedMethods()) //这个是随便写的，只是举例

***
    Koa 的最大特色，就是中间件（middleware）Koa 应用程序是一个包含一组中间件函数的对象，它是按照类似堆栈的方式组织和执行的。
    Koa中使用app.use()用来加载中间件，基本上Koa 所有的功能都是通过中间件实现的。

    每个中间件默认接受两个参数，第一个参数是 Context 对象，第二个参数是next函数。只要调用next函数，就可以把执行权转交给下一个中间件。
    每一个中间件就相当于洋葱的一层，请求从最外层进去，然后从最里层出来，每个中间件都会执行两次。
    所以next()只是执行next后的代码，然后一层一层返回
    
    就好像一个洋葱，请求从外面一层一层进来，再一层一层出去。
```


 

 

    

