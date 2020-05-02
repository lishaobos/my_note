# **前端开发规范**
### 目录 
* [JS书写规范](#js)
* [VUE使用规范](#vue)
* [HTML书写规范](#html)
* [微信小程序开发](#mp)
* [GIT规范](#git)
    * [Commit message 规范](#git-message)
    * [提交前注意事项](#before-commit)
* [CSS书写规范](#css)
    * [书写格式规范](#css-format)
    * [书写顺序规范](#css-prop-sort)

<h2 id="js">JS书写规范</h2>

1. 
    ```
    使用esLint 标准规范
    ```
2. 
    ```
    优先使用 'ES6' 最新标准语法进行开发 
    ```
    参考链接： [阮一峰ES6入门教程](http://es6.ruanyifeng.com/#README)
3. **注释规范**
    ```
    /**
     * 方法功能描述
     * @param param8 { 参数类型 } 参数说明
     * @param param1 {Array} 
     * @param param2 {String}
     * @param param3 {Number}
     * @param param4 {Object} - (对象的属性注释如下：)
     * @param {string} param4.name - (param4的属性注释)
     * @param {number} param4.age  - (param4的属性注释)
     * @param param5 {Boolean} 
     * @param param6 {Function}
     * @param param7 {HTMLElement}
     * @returns {Promise<AxiosResponse<T>>}
     */
    ```
    详细信息：[http://usejsdoc.org/](http://usejsdoc.org/)
3. 避免书写复杂的语句，尽可能的将复杂语句通俗化，也就是提高其可阅读性

<h2 id="vue">VUE使用规范</h2>

1. **基于组件化开发理解**
    1. 什么是组件
    
        组件其实就是页面组成的一部分，好比是电脑中的每一个元件（如硬盘、键盘、鼠标），它是一个具有独立的逻辑和功能或界面，同时又能根据规定的接口规则进行相互融化，变成一个完整的应用。页面只不过是这样组件的容器，组件自由组合形成功能完整的界面，当不需要某个组件，或者想要替换某个组件时，可以随时进行替换和删除，而不影响整个应用的运行。前端组件化的核心思想就是将一个巨大复杂的东西拆分成粒度合理的小东西。
       
    2. 组件化开发的好处
        1. 提高开发效率
        2. 方便重复使用
        3. 简化调试步骤
        4. 提升整个项目的可维护性
        5. 便于协同开发
        6. 使其高内聚，低耦合，达到分治与复用的目的。
    3. 组件化和模块化的区别
    
       组件化是从产品功能角度进行分割，模块化是从代码实现角度进行分割模块化是组件化的前提和基础。

2. **Vue组件化开发**
    1. 单文件系统，样式局部作用域
    2. 基本组成结构：```<template/> <script/> <style scoped/>```
    3. 组件注册方式：
        1. 公共组件全局注册
        2. 其余组件局部注册	
3. **文件命名规范**
    1.	文件夹命名规范：单词与单词之间用连字符“-”连接，单词统一使用小写字母，例如：``element-ui``
    2.	Vue组件命名规范：单词与单词之间用连字符“-”连接，单词首字母大写，例如：``El-Table.vue``
    3.	样式文件命名规范：同文件夹命名规范，例如： ``element-variables.scss``
    4.	其他文件命名方式参考文件夹命名方式！

4. **vue文件方法声明顺序**
    1.	``components``
    2.	``props``
    3.	``data``
    4.	``beforeCreate``
    5.	``created``
    6.	``beforeMount``
    7.	``mounted``
    8.	``beforeUpdate``
    9.	``updated``
    10.	``activated``
    11.	``deactivated``
    12.	``beforeRouteUpdate``
    13.	``methods   ``
    14.	``filter``
    15.	``computed``
    16.	``watch``
    17.	``beforeRouteLeave``
    18.	``beforeDestroy``
    19.	``destroyed``

5. **项目技术栈规范**
    1. 移动端
       ```
       Nodejs@10.15.3 + vue@2.0 + vuex@3.0 + vue-router@3.0
       ```
    1. PC端
       ```
       Nodejs@10.15.3 + vue@2.0 + vuex@3.0 + vue-router@3.0 + element-ui@2.0 
       ```
6. **vue项目目录结构**

      ```

     |--- node_mudules  
     |--- src  
     |--- apis  
         |--- apis  
         |--- assets      
         |--- components      
         |--- directive      
         |--- filter      
         |--- router          
         |--- store              
         |--- views                   
         |--- main.js    
     |--- static               

    ```
7. **接口书写规范**
    1. 接口一律写在 /src/apis 文件夹中
    2. 需写明接口的功能
    3. 接口按照 页面/模块 进行归类，写入单独的js文件中
    4. 每个接口写成可以返回promise对象的箭头函数，请求方法命名具有语义，遵循驼峰命名的方式，并单独导出
    5. 使用  axios “ 别名“方式发起请求，非配置方式
        如：axios.get() 而非 axios.get({ method: ‘get’ })
    6. 写好注释
        如:
        ```
        /**
         * 学员信息编辑
         * @param data {Array} [{defaultStatus, stuMobile, stuName, id}]
         * @returns {Promise<AxiosResponse<T>>}
         */
        export const edit = data => axios.post('/apis/v1/studentmanagement/update', data) 
        ```
8.  **`v-if` 与 `v-show`的使用规范**

   1. 需要频繁展示和隐藏的dom需使用`v-show`
   2. 与第1条相反，须使用`v-if`
   3. 安全性优先：如需频繁显示和隐藏且有安全风险，须使用`v-if`
      1. 安全风险是指，一些拥有专业知识的人员，可能会使用控制台，让使用了`v-show`的一些敏感操作显示出来，
      
            并进行本不该进行的一系列操作，从而给网站带来风险

<h2 id="html">HTML书写规范</h2>

1. 标签的嵌套层级不宜过多（如果一个简单的布局超过5层，需要自我反省）
2. 缩 使用2个空格
3. 严格遵守语义化规范，不滥用标签
4. 标签属性过多时，换行书写
5. 尽量少写行内样式

<h2 id="mp">微信小程序开发</h2>
1. 暂且依据vue开发规范

<h2 id="git">GIT规范</h2>

<h3 id="git-message">Commit message 规范</h3>

1. type代表某次提交的类型，比如是修复一个bug还是增加一个新的feature。所有的type类型如下：
2. feat： 新增feature
3. fix: 修复bug
4. docs: 仅仅修改了文档，比如README, CHANGELOG, CONTRIBUTE等等
5. style: 仅仅修改了空格、格式缩进、都好等等，不改变代码逻辑
6. refactor: 代码重构，没有加新功能或者修复bug
7. perf: 优化相关，比如提升性能、体验
8. test: 测试用例，包括单元测试、集成测试等
9. chore: 改变构建流程、或者增加依赖库、工具等
10. revert: 回滚到上一个版本
    举个例子：
    ```
    修改bug #1234  这是一个bug 的描述。
    commit message 应该这么写：
        fix: #1234 这是一个bug的描述
    其他commit 与之类似，只要使用不同的commit type 作为前缀就行了
    ```

<h3 id="before-commit">提交前注意事项</h3>
为了使得提交试图更优雅，在提交代码前因遵顼以下规范：

1. 先pull或fetch  
    1. 先拉取，在拉取时，应使用rebase (变基)，获取在拉取前将代码 stash (贮藏) ，这样能避免一次代码合并
2. 变基： 在 Git 中整合来自不同分支的修改主要有两种方法：merge 以及 rebase，  
在拉取代码时，如遇到不同代码，merge大多数情况下是git的默认行为；
变基如同重新播放，可以将一条分支上的修改移动到另一条分支上，这样，你就可以在新的代码上继续进行提交了，而不会产生合并代码的提交；  
举个实际应用中的例子：你在dev-1.0.0上开发完成，准备提交，但是origin/dev-1.0.0上已被其他人提交过新的代码，此时直接提交并推送将会产生一次合并，但是如果只提交到dev-v1.0.0，再将使用变基将origin/dev-1.0.0的代码“变基”到dev-1.0.0上，在进行推送，如果过程中存在冲突，将会是另外一种景象；  
关于rebase的更多用法，可参考： [https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%8F%98%E5%9F%BA](https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%8F%98%E5%9F%BA)
3. 提交&推送

<h2 id="css">CSS书写规范</h3>
<h3 id="css-format">书写格式规范</h3>

1. 不使用ID选择器
2. 不适用*选择器
3. 选择器层级不超过3层
4. Class 名称需要富有语义化
5. 颜色属性值小写
6. 属性与属性值之间用一个空格
7. 选择器后紧跟一个空格
8. 使用两个空格缩进
9. 颜色值使用缩写
10. 选择器小写
    ```
    .a {
      color: #fff;
      background-color: #fff;
    }
    ```
11. 小数省略0
    ```
    li > a {
      opacity: .5
    }
    ```
12. 使用单引号
    ```
    p: after {
      content: '';
    }
    ```
13.	子代选择器两端留有一个空格
    ```
    .a > span {
      color: red;
    }
    ```
    
<h3 id="css-prop-sort">书写顺序规范</h3>

1. 位置属性
    1. `position`
    2. `z-index`
    3. `top`
    4. `right`
    5. `bottom`
    6. `left `
    7. `display`
    8. `visibility`
    9. `float`
    10. `clear`
    11. `overflow`
    12. `overflow-x`
    13. `overflow-y`
    14. `-ms-overflow-x`
    15. `-ms-overflow-y`
    16. `clip`
    17. `zoom`
    18. `flex-direction`
    19. `flex-order`
    20. `flex-pack`
    21. `flex-align`
2. 盒模型属性
    1. `-webkit-box-sizing`
    2. `-moz-box-sizing`
    3. `box-sizing`
    4. `width`
    5. `min-width`
    6. `max-width`
    7. `height`
    8. `min-height`
    9. `max-height`
    10. `margin`
    11. `margin-top`
    12. `margin-right`
    13. `margin-bottom`
    14. `margin-left`
    15. `padding`
    16. `padding-top`
    17. `padding-right`
    18. `padding-bottom`
    19. `padding-left`
    20. `border`
    21. `border-width`
    22. `border-style`
    23. `border-color`
    24. `border-top`
    25. `border-top-width`
    26. `border-top-style`
    27. `border-top-color`
    28. `border-right`
    29. `border-right-width`
    30. `border-right-style`
    31. `border-right-color`
    32. `border-bottom`
    33. `border-bottom-width`
    34. `border-bottom-style`
    35. `border-bottom-color`
    36. `border-left`
    37. `border-left-width`
    38. `border-left-style`
    39. `border-left-color`
    40. `border-radius`
    41. `border-top-left-radius`
    42. `border-top-right-radius`
    43. `border-bottom-right-radius`
    44. `border-bottom-left-radius`
    45. `border-image`
    46. `border-image-source`
    47. `border-image-slice`
    48. `border-image-width`
    49. `border-image-outset`
    50. `border-image-repeat`
3. 表格属性
    1. `table-layout`
    2. `empty-cells`
    3. `caption-side`
    4. `border-spacing`
    5. `border-collapse`
    6. `list-style`
    7. `list-style-position`
    8. `list-style-type`

4. 文字排版属性
    1. `font`
    2. `font-family`
    3. `font-size`
    4. `font-weight`
    5. `font-style`
    6. `font-variant`
    7. `font-size-adjust`
    8. `font-stretch`
    9. `font-effect`
    10. `font-emphasize`
    11. `font-emphasize-position`
    12. `font-emphasize-style`
    13. `font-smooth`
    14. `line-height`
5. 视觉与背景属性
    1. `opacity`
    2. `filter:progid:DXImageTransform.Microsoft.Alpha(Opacity`
    3. `-ms-filter:\\'progid:DXImageTransform.Microsoft.Alpha`
    4. `-ms-interpolation-mode`
    5. `color`
    6. `outline`
    7. `outline-width`
    8. `outline-style`
    9. `outline-color`
    10. `outline-offset`
    11. `background`
    12. `filter:progid:DXImageTransform.Microsoft.AlphaImageLoader`
    13. `background-color`
    14. `background-image`
    15. `background-repeat`
    16. `background-attachment`
    17. `background-position`
    18. `background-position-x`
    19. `-ms-background-position-x`
    20. `background-position-y`
    21. `-ms-background-position-y`
    22. `-webkit-background-clip`
    23. `-moz-background-clip`
    24. `background-clip`
    25. `background-origin`
    26. `-webkit-background-size`
    27. `-moz-background-size`
    28. `-o-background-size`
    29. `background-size`
    30. `box-decoration-break`
    31. `-webkit-box-shadow`
    32. `-moz-box-shadow`
    33. `box-shadow`
    34. `filter:progid:DXImageTransform.Microsoft.gradient`
    35. `-ms-filter:\\'progid:DXImageTransform.Microsoft.gradient`
    36. `text-shadow`

6. 其他属性
    1. `content`
    2. `quotes`
    3. `counter-reset`
    4. `counter-increment`
    5. `resize`
    6. `cursor`
    7. `user-select`
    8. `nav-index`
    9. `nav-up`
    10. `nav-right`
    11. `nav-down`
    12. `nav-left`
    13. `transition`
    14. `transition-delay`
    15. `transition-timing-function`
    16. `transition-duration`
    17. `transition-property`
    18. `transform`
    19. `transform-origin`
    20. `animation`
    21. `animation-name`
    22. `animation-duration`
    23. `animation-play-state`
    24. `animation-timing-function`
    25. `animation-delay`
    26. `animation-iteration-count`
    27. `animation-direction`
    28. `text-align`
    29. `text-align-last`
    30. `vertical-align`
    31. `white-space`
    32. `text-decoration`
    33. `text-emphasis`
    34. `text-emphasis-color`
    35. `text-emphasis-style`
    36. `text-emphasis-position`
    37. `text-indent`
    38. `text-justify`
    39. `letter-spacing`
    40. `word-spacing`
    41. `-ms-writing-mode`
    42. `text-outline`
    43. `text-transform`
    44. `text-wrap`
    45. `text-overflow`
    46. `text-overflow-ellipsis`
    47. `text-overflow-mode`
    48. `word-wrap`
    49. `word-break`
    50. `tab-size`
    51. `hyphens`
    52. `pointer-events`



    
