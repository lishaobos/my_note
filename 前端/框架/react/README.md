# React

## 安装

```
npm init react-app my-app
```

## 组件

### 组件定义方式


```
// 函数式（无法使用 state 属性，属于无状态组件）
const snake  = (props) => {
  // 这个props可以接受我们父组件传进来的自定义属性 
  // props.children 相当于vue插槽,这个props是我们定义的形参
  return <h1> 啦啦啦 {props.name} </h1>
}
```


```
// 类的方式 （可以使用 state 属性，属于有状态组件，这种方式里面可以继承或者调用父类的方法）
class snake extends react.component {
  render(){
    // 这里面得用this.props，是系统提供的
    return <h1> 啦啦啦 {this.props.name} </h1>
  }
}
```

### 组件选择

  1. 有状态组件有生命周期，无状态组件是没生命周期的

  2. 如果只接受传进来的数据处理，就用无状态组件，如果需要 state 进行一些数据的操作，那就选有状态组件

  3. 一般建议使用无状态组件，因为有状态组件是有生命周期的，会影响到我们整个项目的运行

  4. 有状态就是 class 无状态就是一个函数
  
  5. 一个通过 this.props 接受参数，一个通过函数传进来的形参来接收参数


### 属性的绑定

```
:name="mes"  // 这个是vue 
name={this.state.mes} // 这个是react，没有引号，直接单括号
```

### 事件

组件的事件只能在组件中定义，如果组件是被引入的，我们必须把方法传过去，在组件中 props.方法 就行了

### 组件类的格式：(注意jsx的语法，里面直接等于号就行了)

```
1.state 相当于 vue data
    state = {} 

2.函数是直接写，和 state 平级，要用 es6 的箭头函数，要不然 this 是指向 window，或者使用 bind
    change = () => {}

3.事件函数里面如果要改变我们state里面的某个参数(这个和我们微信小程序语法是一样的)
    this.setState({
        mes:'xxx'
    });
```

### 样式

对于样式，必须用 import 引入我们的css文件才可以 注：不是@import，而且jsx中 className 代替了class

## JSX 语法

```
// 这里面可以用大括号括起来一段 html 节点
// 这个是用三目运算符，如果为 true 就展示这段 html
// render 是只要有改变就会触发
render() {
  return (
    <div className="App">
      <div>
        <h1>你好bro</h1>
        <input type="button" onClick={this.changes} value="点击" />
        { 
          this.state.flag == true ?
          <Practice 
            model={this.model}
            name={this.state.mes[0].name}
            age={this.state.mes[0].age}
          >
            <span>asd</span>
          </Practice>
          : null
        }
      </div>
    </div>
  );
}
```

```
// 下面这个使用了 jsx 语法，和上面的效果是一样的，只是把代码抽离出来，结构更加清晰
render() {
  let yo = null
  if(this.state.flag){
    yo = (
      <Practice 
          model={this.model}
          name={this.state.mes[0].name}
          age={this.state.mes[0].age}
        >
        <span>asd</span>
      </Practice>       
    )
  }

  return (
    <div className="App">
      <div>
        <h1>你好bro</h1>
        <input type="button" onClick={this.changes} value="点击" />
        { yo }
      </div>
    </div>
  );
}
```

```
// 在 return 的代码片段中 {} 大括号是没有什么影响的，而且还支持基本的运算

yo = (
  this.state.mes.map((e,a,b) => {
    return (
      <Practice
        key={a}
        name={e.name}
        age={e.age}
      >
        <span>asd</span>
      </Practice>
    );
  })
)
```

### 钩子函数

1. 对于react灵魂组件的钩子函数
  1. constructor()           调用父级 super(props)  设置状态state
  2. componentWillMount()    修改状态
  3. render()                创建虚拟dom，更新DOM
  4. componentDidUpdate()    组件更新后调用
  5. componentDidMount()     组件渲染完毕，不要更新状态
  6. componentWillUnmount()  组件即将卸载

2. 不常用的钩子函数
  1. shouldComponentUpdate()
      - 若返回 false，则不会调用 componentWillUpdate()，render() 和 componentDidUpdate()。
  2. getDerivedStateFromProps()
      - 会在调用 render 方法之前调用，并且在初始挂载及后续更新时都会被调用。它应返回一个对象来更新 state，如果返回 null 则不更新任何内容
  3. getSnapshotBeforeUpdate()
      - 在最近一次渲染输出（提交到 DOM 节点）之前调用。它使得组件能在发生更改之前从 DOM 中捕获一些信息（例如，滚动位置）。此生命周期方法的任何返回值将作为参数传递给 componentDidUpdate()。
  4. forceUpdate()
      - 强制更新


### 绑定this

```
class a extends Component {
  constructor(){
    // 官方建议在constructor函数中绑定，主要是为了解决js中this指向混乱的问题
    this.change = this.change.bind(this)
  }
  change(){

  }
}
```

## 路由

1. react-router 是 v3 版本，此版本支持路由嵌套的写法
2. react-router-dom 是v4 版本 

```
import {BrowserRouter as Router, Route, Link} from 'react-router-dom' 
// <Router /> 相当于我们vue的  <router-view />

// v3:
<Router>
  <Route path="/a" component={a} >
    <Router path="/a-1" component={a-1} />
  </Route>
</Router>

// v4
<Router>
  <Route path="/a" component={a} ></Route>
  <Router path="/a/a-1" component={a-1} />
</Router>
```


## Redux

因为react是单向数据流，所以如果没有关系的组件之间传递参数得先往父组件传上去，再慢慢传到要传的组件，很复杂
所以redux就出现了，他可以给两个没有关系的组件创建一个父组件，也就是一个状态，存储的这两个组件所需要的信息，
然后我们两个组件之间就产生了联系，可以互相传递参数


1.得先安装 redux 然后引入这两个

```
import {createStore} from 'redux';
import {combineReducers} from 'redux';
```

2.这俩是随便定义的

```
let mes1 = '我是a和b都可以用';
let mes2 = '我是c和d都可以用';
```

3.下面写了两个方法，也就是我们的reducer，action就是我们如果 dispatch，然后判断就可以修改全局的状态

```
let one = (state=mes1,action) => {
    switch(action.type){
        case 'ab':
            return {...state, a:'aabb'};
        default:
            return {state, a:'aabb'};
    }
}

let two = (state=mes2,action) => {
    switch(action.type){
        case 'cd':
            return {state,...action};
        default:
            return {state,a:'ccdd'};
    }
}
```

4.这个方法的作用就是合并reducer，把他们的结果合并成一个state对象
let all = combineReducers({
    one,
    two
});

5.这个就是我们创建store的方法，之后把这个导出就行了
let store = createStore(
    all
)

provider 是 react-redux里面的
你说的是 redux-thunk 吧，redux默认的设定是 dispatch 只能接受一个对象参数，
函数和promise都是不允许的，这个中间件就是为了解决这个问题的

applyMiddleware 是可以把所有中间件合成的一个函数

对于使用Provider和connect的使用
1.引入
import {Provider} from 'react-redux'
import Store from './ca/xxx' //这个是我们创建好的Store，引进来

2.把Provider标签包住我们的组件
ReactDOM.render(<Provider store={Store}><App /></Provider>, document.getElementById('root'));

3.定义很多个dispatch要使用的对象，例:
export const add=()=>{ //这只是其中的一个
    return {
        type:'cd',
        payload:'q'
    }
}

4.在我们所需要的组件中引入需要的模块
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'
import * as act from './actions/xx'  //这个是引入我们第三步的所有东西

5.在有生命周期的组件中
  1.先在最下面
     const getstore=(state)=>({ //这个函数是为了接收库里面的数据 
      datas:state
     })
     const dis=(dispatch)=>({  //这个是为了接收所有的dispatch方法
      actions:bindActionCreators(act,dispatch)
     })
     export default connect(getstore,dis)(App); //这一步就是实现打通通道的方法
  2.在生命周期的函数里面
    constructor(props){
      super(props);
      然后我们 this.props 里面有我们所有的方法和参数，就ok了。
    }

