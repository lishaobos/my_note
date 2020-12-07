/**
  "off" 或者0，不启用这个规则
  "warn" 或者1，出现问题会有警告
  "error" 或者2，出现问题会报错
 */
module.exports = {
  "ignorePatterns": ['dist/*'],
  "root": true,
  "env": {
    "node": true
  },
  "extends": [
    "plugin:eslint-plugin-leon-rule/recommended",
    "plugin:vue/recommended",
    "plugin:vue/essential",
    "@vue/standard",
  ],
  "parserOptions": {
    "parser": "babel-eslint"
  },
  "rules": {
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    "no-var": 2,
  }
}

// TS 的校验
https://github.com/typescript-eslint/typescript-eslint/blob/master/docs/getting-started/linting/README.md