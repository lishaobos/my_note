const path = require('path')
const fs = require('fs')

const readDir = async dirPath => {
  const fileList = await fs.readdirSync(dirPath)
  for (const item of fileList) {
    const filePath = path.resolve(dirPath, item)
    if (fs.lstatSync(filePath).isDirectory()) {
      const list = await readDir(filePath)
      fileList.push(...list.map( childPath => `${item}/${childPath}`))
    }
  }

  return fileList
}

const readFile = async path => await fs.readFileSync(path, { encoding: 'utf8' })

const createFile = async (path, content) => await fs.writeFileSync(path, content)

const injectHtml = (htmlStr, tagName, injectStr) => {
  const startTag = `<${tagName}>`
  const endTag = `</${tagName}>`
  const reg = new RegExp(`${startTag}[\\s\\S]*${endTag}`, 'g')
  const matchStr = htmlStr.match(reg)[0]
  const fragementHtml = matchStr.replace(endTag, '') + injectStr + endTag

  return htmlStr.replace(matchStr, fragementHtml)
}

createSourceTemplate = fileList => {
  const data = {
    css: '',
    js: '',
  }
  const isCssFile = /.css$/
  const isJsFile = /.js$/

  fileList.forEach(item => {
    if (isCssFile.test(item)) {
      data.css += `<link rel='stylesheet' href=${item} />`
    } else if (isJsFile.test(item)) {
      data.js += `<script src=${item}></script>`
    }
  })

  return data
}

module.exports = class HtmlPlugin {

  constructor(options) {
    this.options = options
  }

  apply(compiler) {
    const dirName = compiler.options.output.path || path.resolve('dist')
    
    compiler.hooks.done.tap('HtmlPlugin', async compilation => {
      const result = await readDir(dirName)
      const { css, js } = createSourceTemplate(result)
      const htmlStr = await readFile(this.options.template)
      let resultStr = injectHtml(htmlStr, 'head', css)
      resultStr = injectHtml(resultStr, 'body', js)
      
      const filePath = path.resolve(dirName, 'index.html')
      await createFile(filePath, resultStr)
    })
  }
}