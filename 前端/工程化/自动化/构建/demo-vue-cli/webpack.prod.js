const path = require('path')
const merge = require('webpack-merge')
const common = require('./webpack.common.js')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
const TerserJSPlugin = require('terser-webpack-plugin')

module.exports = merge(common, {
  mode: 'production',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name]-[hash:10].js'
  },
  optimization: {
    minimize: true,
    minimizer: [
      new TerserJSPlugin({
        extractComments: false
      }),
      new OptimizeCSSAssetsPlugin()
    ]
  },
  plugins: [
    new CopyWebpackPlugin({
      patterns: [
        { from: 'public/favicon.ico', to: './' }
      ]
    })
  ]
})
