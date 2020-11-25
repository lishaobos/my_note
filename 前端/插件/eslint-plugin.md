# Eslint Plugin

## 插件脚手架

```
npm i -g yo generator-eslint
```

### 创建插件

```
// 创建插件
yo eslint:plugin

// 创建规则
yo eslint:rule
```

## 插件规则创建

简单说明：eslint 原理是根据 AST 语法树的规则去做校验

- [Eslint 插件规则](https://eslint.org/docs/developer-guide/working-with-rules)

- [AST 调试网站](https://astexplorer.net/)

## 遇到的问题点

- 1.--rulesdir 产生的运行时规则和编辑器有兼容问题

- 2.rulesConfig 已经被弃用

- 3.正确的配置格式（以写好的插件举例子）
    - [eslint-plugin-leon-rule](https://github.com/lishaobos/eslint-plugin-leon-rule)
    ```
    // no-then.js
    module.exports = {
        meta: {
            docs: {
                description: "disable then function",
                category: "Fill me in",
                recommended: false
            },
            fixable: null,  // or "code" or "whitespace"
            schema: [
                // fill in your schema
            ]
        },
        create (ctx) {
            return {
                'MemberExpression' (node) {
                    if (node?.object?.type === 'CallExpression' && node?.property?.name === 'then') {
                        ctx.report({
                            node,
                            message: 'use async await, not then'
                        })
                    }
                }
            }
        }
    };

    // main.js
    module.exports = {
        rules: {
            'no-then': require('no-then.js')
        },
        configs: {
            recommended: {
                plugins: ["leon-rule"],
                rules: {
                    'leon-rule/no-then': 2,
                    'leon-rule/await-to-next-tick': 2,
                }
            }
        }
    }

    // vue .eslintrc.js plugin:[packageName]/[key]
    extends: ["plugin:eslint-plugin-leon-rule/recommended"]
    ```