const fs = require('fs')

let options = {
  inject: 'append'
}

const injector = {
  append(content, resource) {
    return content + resource
  },
  prepend(content, resource) {
    return resource + content
  }
}

const getResource = async () => {
  const { patterns } = options
  const result = await fs.readFileSync(patterns, { encoding: "utf-8" })
  return result
}

const injectResource = (content, resource) => {
  const { inject } = options

  if (injector[inject]) {
    return injector[inject](content, resource)
  }

  throw new Error('不存在这种注入方式')
}

exports.loadResource = async (ctx, content) => {
  options = { ...options, ...ctx.getOptions()}
  const cb = ctx.async()

  const resource = await getResource()
  const result = injectResource(content, resource)

  cb(null, result)
}