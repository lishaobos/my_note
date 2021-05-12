# MongoDB

说明：
MongoDB中的记录是一个文档，它是由字段和值对组成的数据结构。MongoDB文档类似于JSON对象。字段的值可以包括其他文档，数组和文档数组，是 nosql 数据库里面关系性最强的。

- [官网](https://docs.mongodb.com/manual/)
- [运算符](https://docs.mongodb.com/manual/reference/operator/query/)
- [node 操作 mongodb](https://docs.mongodb.com/manual/tutorial/query-embedded-documents/)

代码示例：
```
const { MongoClient } = require('mongodb')

// mongodb 默认连接地址
const url = `mongodb://localhost:27017`
// 数据库名称
const dbName = 'mJob'
const client = new MongoClient(url)

const connect = async () => {
  // 创建连接
  await client.connect();
  // 连接数据库
  const db = await client.db(dbName);
  // 连接数据库里面某个集合(sourceMap)
  const ctx = await db.collection('sourceMap')

  // await insert(ctx)
  // await insertMany(ctx)
  // await findOne(ctx)
  // await find(ctx)
  // await updateOne(ctx)
  // await updateMany(ctx)
  // await deleteMany(ctx)

  client.close();
}

connect()

const insert = async ctx => {
  const { result } = await ctx.insertOne({ name: 'dog', age: 0 })
  console.log(result)
}

const insertMany = async ctx => {
  const stack = []
  for (let i = 0; i <= 10; i++) {
    stack.push({ name: `dog-${i}`, age: i })
  }

  const { result } = await ctx.insertMany(stack)
  console.log(result)
}

const findOne = async ctx => {
  const data = await ctx.findOne({ age: 5 })
  console.log(data)
}

const find = async ctx => {
  const data = await ctx.find({ age: { $gt: 5 } }, { sort: { age: -1  } }).toArray()
  console.log(data)
}

const updateOne = async ctx => {
  const data = await ctx.updateOne({ age: { $gt: 5 } }, { $set: { sex: 1 } })
  console.log(data.result)
}

const updateMany = async ctx => {
  const data = await ctx.updateMany({ age: { $gt: 5 } }, { $set: { sex: 1 } })
  console.log(data.result)
}

const deleteMany = async ctx => {
  const data = await ctx.deleteMany({ age: { $gt: 5 } })
  console.log(data.result)
}
```