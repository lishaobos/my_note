const path = require('path')
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const HtmlPlugin = require('./html-plugin')

module.exports = {
  mode: 'production',
  entry: './src/main.js',
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/[name].css'
    }),
    new HtmlPlugin({
      template: path.resolve('./src/index.html')
    })
  ],
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          {
            loader: path.resolve('./source-loader/index.js'),
            options: {
              inject: 'prepend',
              patterns: path.resolve('./src/css/newStyle.css')
            }
          },
        ]
      }
    ]
  }
}