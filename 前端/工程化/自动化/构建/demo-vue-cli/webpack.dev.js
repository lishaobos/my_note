const merge = require('webpack-merge')
const common = require('./webpack.common.js')

module.exports = merge(common, {
  mode: 'development',
  devServer: {
    contentBase: 'public',
    hot: true,
    port: 9527,
    open: true
  }
})
