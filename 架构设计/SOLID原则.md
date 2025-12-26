# SOLID 原则

SOLID 是面向对象设计的五大基本原则,由 Robert C. Martin 提出,旨在提高代码的可维护性、可扩展性和可读性。

## 1. SRP - Single Responsibility Principle (单一职责原则)

**定义**: 一个类应该只有一个引起它变化的原因,即一个类只负责一项职责。

### 核心思想
- 每个类或模块应该专注于做一件事情
- 降低类的复杂度
- 提高代码的可读性和可维护性
- 降低变更带来的风险

### 示例

❌ **违反 SRP 的代码**:
```javascript
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }
  
  // 用户数据管理
  getUserInfo() {
    return { name: this.name, email: this.email };
  }
  
  // 数据库操作 - 不应该在这里
  saveToDatabase() {
    // 数据库保存逻辑
    console.log('Saving to database...');
  }
  
  // 邮件发送 - 不应该在这里
  sendEmail(message) {
    console.log(`Sending email to ${this.email}: ${message}`);
  }
}
```

✅ **符合 SRP 的代码**:
```javascript
// 用户实体 - 只负责用户数据
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }
  
  getUserInfo() {
    return { name: this.name, email: this.email };
  }
}

// 用户仓储 - 只负责数据持久化
class UserRepository {
  save(user) {
    console.log('Saving user to database...', user.getUserInfo());
  }
}

// 邮件服务 - 只负责邮件发送
class EmailService {
  sendEmail(email, message) {
    console.log(`Sending email to ${email}: ${message}`);
  }
}
```

---

## 2. OCP - Open/Closed Principle (开放封闭原则)

**定义**: 软件实体(类、模块、函数等)应该对扩展开放,对修改封闭。

### 核心思想
- 在不修改现有代码的情况下添加新功能
- 通过抽象和多态实现
- 降低修改现有代码带来的风险

### 示例

❌ **违反 OCP 的代码**:
```javascript
class PaymentProcessor {
  processPayment(type, amount) {
    if (type === 'credit_card') {
      console.log(`Processing credit card payment: ${amount}`);
    } else if (type === 'paypal') {
      console.log(`Processing PayPal payment: ${amount}`);
    } else if (type === 'crypto') {
      // 添加新支付方式需要修改这个类
      console.log(`Processing crypto payment: ${amount}`);
    }
  }
}
```

✅ **符合 OCP 的代码**:
```javascript
// 支付接口
class PaymentMethod {
  process(amount) {
    throw new Error('Method must be implemented');
  }
}

// 具体支付方式实现
class CreditCardPayment extends PaymentMethod {
  process(amount) {
    console.log(`Processing credit card payment: ${amount}`);
  }
}

class PayPalPayment extends PaymentMethod {
  process(amount) {
    console.log(`Processing PayPal payment: ${amount}`);
  }
}

class CryptoPayment extends PaymentMethod {
  process(amount) {
    console.log(`Processing crypto payment: ${amount}`);
  }
}

// 支付处理器 - 无需修改即可支持新支付方式
class PaymentProcessor {
  processPayment(paymentMethod, amount) {
    paymentMethod.process(amount);
  }
}

// 使用
const processor = new PaymentProcessor();
processor.processPayment(new CreditCardPayment(), 100);
processor.processPayment(new CryptoPayment(), 200);
```

---

## 3. LSP - Liskov Substitution Principle (里氏替换原则)

**定义**: 子类对象必须能够替换掉所有父类对象,且程序行为不变。

### 核心思想
- 子类必须实现父类的所有抽象方法
- 子类可以扩展父类功能,但不能改变父类原有的功能
- 子类的返回值类型应该与父类相同或更具体
- 子类不应该抛出父类没有声明的异常

### 示例

❌ **违反 LSP 的代码**:
```javascript
class Bird {
  fly() {
    console.log('Flying...');
  }
}

class Penguin extends Bird {
  fly() {
    // 企鹅不会飞,这违反了 LSP
    throw new Error('Penguins cannot fly!');
  }
}

function makeBirdFly(bird) {
  bird.fly(); // 如果传入 Penguin,会抛出异常
}
```

✅ **符合 LSP 的代码**:
```javascript
class Bird {
  move() {
    console.log('Moving...');
  }
}

class FlyingBird extends Bird {
  move() {
    this.fly();
  }
  
  fly() {
    console.log('Flying...');
  }
}

class Penguin extends Bird {
  move() {
    this.swim();
  }
  
  swim() {
    console.log('Swimming...');
  }
}

function makeBirdMove(bird) {
  bird.move(); // 所有鸟类都能正常执行
}
```

---

## 4. ISP - Interface Segregation Principle (接口隔离原则)

**定义**: 客户端不应该依赖它不需要的接口,一个类对另一个类的依赖应该建立在最小的接口上。

### 核心思想
- 拆分臃肿的接口为更小的、更具体的接口
- 客户端只需要知道它们感兴趣的方法
- 避免接口污染

### 示例

❌ **违反 ISP 的代码**:
```javascript
class Printer {
  print(document) {}
  scan(document) {}
  fax(document) {}
}

// 简单打印机只需要打印功能,但被迫实现所有方法
class SimplePrinter extends Printer {
  print(document) {
    console.log('Printing:', document);
  }
  
  scan(document) {
    throw new Error('Scan not supported');
  }
  
  fax(document) {
    throw new Error('Fax not supported');
  }
}
```

✅ **符合 ISP 的代码**:
```javascript
// 拆分成多个小接口
class Printable {
  print(document) {
    throw new Error('Method must be implemented');
  }
}

class Scannable {
  scan(document) {
    throw new Error('Method must be implemented');
  }
}

class Faxable {
  fax(document) {
    throw new Error('Method must be implemented');
  }
}

// 简单打印机只实现需要的接口
class SimplePrinter extends Printable {
  print(document) {
    console.log('Printing:', document);
  }
}

// 多功能打印机实现所有接口
class MultiFunctionPrinter {
  constructor() {
    this.printable = new PrintableImpl();
    this.scannable = new ScannableImpl();
    this.faxable = new FaxableImpl();
  }
  
  print(doc) { this.printable.print(doc); }
  scan(doc) { this.scannable.scan(doc); }
  fax(doc) { this.faxable.fax(doc); }
}
```

---

## 5. DIP - Dependency Inversion Principle (依赖倒置原则)

**定义**: 
- 高层模块不应该依赖低层模块,两者都应该依赖抽象
- 抽象不应该依赖细节,细节应该依赖抽象

### 核心思想
- 面向接口编程,而不是面向实现编程
- 依赖注入是实现 DIP 的常用方式
- 降低模块间的耦合度

### 示例

❌ **违反 DIP 的代码**:
```javascript
// 低层模块
class MySQLDatabase {
  save(data) {
    console.log('Saving to MySQL:', data);
  }
}

// 高层模块直接依赖低层模块的具体实现
class UserService {
  constructor() {
    this.database = new MySQLDatabase(); // 强依赖
  }
  
  saveUser(user) {
    this.database.save(user);
  }
}
```

✅ **符合 DIP 的代码**:
```javascript
// 抽象层
class Database {
  save(data) {
    throw new Error('Method must be implemented');
  }
}

// 低层模块实现抽象
class MySQLDatabase extends Database {
  save(data) {
    console.log('Saving to MySQL:', data);
  }
}

class MongoDatabase extends Database {
  save(data) {
    console.log('Saving to MongoDB:', data);
  }
}

// 高层模块依赖抽象
class UserService {
  constructor(database) {
    this.database = database; // 依赖注入
  }
  
  saveUser(user) {
    this.database.save(user);
  }
}

// 使用
const mysqlDB = new MySQLDatabase();
const userService1 = new UserService(mysqlDB);

const mongoDB = new MongoDatabase();
const userService2 = new UserService(mongoDB);
```

---

## SOLID 原则总结

| 原则 | 简称 | 核心思想 | 解决的问题 |
|------|------|----------|-----------|
| 单一职责 | SRP | 一个类只做一件事 | 降低复杂度,提高可维护性 |
| 开放封闭 | OCP | 对扩展开放,对修改封闭 | 提高可扩展性,降低修改风险 |
| 里氏替换 | LSP | 子类可以替换父类 | 保证继承的正确性 |
| 接口隔离 | ISP | 接口最小化,按需定制 | 避免接口污染 |
| 依赖倒置 | DIP | 依赖抽象而非具体实现 | 降低耦合度 |

## 实践建议

1. **逐步重构**: 不要试图一次性让所有代码符合 SOLID,应该在迭代中逐步改进
2. **权衡取舍**: 过度设计会导致代码过于复杂,要根据实际需求权衡
3. **代码审查**: 在代码审查中关注 SOLID 原则的应用
4. **测试驱动**: SOLID 原则使代码更易于测试
5. **团队共识**: 确保团队对这些原则有共同的理解

## 与其他原则的关系

- **与 DRY (Don't Repeat Yourself) 的关系**: SRP 有助于实现 DRY
- **与 KISS (Keep It Simple, Stupid) 的关系**: 需要平衡 SOLID 和简单性
- **与 YAGNI (You Aren't Gonna Need It) 的关系**: 不要为了 OCP 过度设计
