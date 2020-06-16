## Yeoman

### 安装步骤

```
// 全局范围安装 yo
yarn global add yo

// 安装对应的 Generator
yarn global add generator-node

mkdir my-test

cd my-test

// 通过 yo 运行 Generator
yo node 

```

---

### 生成 Sub-Generator

说明：针对已有项目中添加特定的文件，也就相当于 plop


```
// 例子 (yo generrator名称:sub-generatro 名称)
yo node:cli

// 添加模块到全局范围
yarn link

// 运行模块命令
my-test --help

```

---

### Yeoman 使用步骤总结

- 1.明确需求

- 2.找到合适的 Generator

- 3.全局范围安装 Generator

- 4.通过 yo 运行对应的 Generator

- 5.通过命令行填写选项

- 6.生成需要的项目结构

---

### 创建 Generator

- 创建 Generator 模块本质上就是创建一个 NPM 模块

- 注意： Generator 模块必须是 generator-(name) 这种格式

#### Generator 基本结构

```
project
│—— generators/  ········· 生成器目录
|    │
|    └─── app/  ··········· 默认生成器目录
│       │
│       └─── index.js  ··· 默认生成器实现
│   
└── package.json  ········ 模块包配置文件
```

#### Generator 准备其他 sub-generator

```
project
│—— generators/  ········· 生成器目录
|    │
|    └─── app/  ··········· 默认生成器目录
│    |  │
│    |  └─── index.js  ··· 默认生成器实现
|    |  
|    └─── component/  ··· 其他生成器目录
|        │
│        └─── index.js  ··· 其他生成器实现
│   
└── package.json  ········ 模块包配置文件
```

#### 创建示例

```
mkdir generator-fuck

cd generator-fuck

yarn init

// 安装一个生成 generator 的基类
yarn add yeoman-generator

// 然后创建文件生成 Generator 基本结构

// 继承 class Generator 里面的方法按照下面顺序运行
1.initializing -您的初始化方法（检查当前项目状态，获取配置等）

2.prompting-在提示用户输入选项的地方（您要致电的地方this.prompt()）

3.configuring-保存配置并配置项目（创建.editorconfig文件和其他元数据文件）

4.default -如果方法名称与优先级不匹配，它将被推送到该组。

5.writing -在其中写入生成器特定文件（路由，控制器等）的位置

6.conflicts -处理冲突的地方（内部使用）

7.install -运行安装的位置（npm，凉亭）

8.end-最后一次打扫，打扫，说再见等

// 添加模块命令到全局
yarn link

// 随便创建一个文件夹
mkdir demo

cd demo

// 运行刚才创建的 Generator 命令
yo fuck
```

---

### 发布 Generator

```
// 创建一个 git 仓库，拉到本地

// 进入文件，发布
yarn publish

```

