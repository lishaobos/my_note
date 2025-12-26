# 架构设计原则

本目录包含软件架构设计的核心原则和最佳实践。

## 📚 内容目录

### 1. [SOLID 原则](./SOLID原则.md)
面向对象设计的五大基本原则,适用于类和对象的设计:

- **SRP** - 单一职责原则 (Single Responsibility Principle)
- **OCP** - 开放封闭原则 (Open/Closed Principle)
- **LSP** - 里氏替换原则 (Liskov Substitution Principle)
- **ISP** - 接口隔离原则 (Interface Segregation Principle)
- **DIP** - 依赖倒置原则 (Dependency Inversion Principle)

### 2. [组件内聚原则](./组件内聚原则.md)
关于如何组织类和模块成组件的三大原则:

- **REP** - 复用/发布等同原则 (Reuse/Release Equivalence Principle)
- **CCP** - 共同封闭原则 (Common Closure Principle)
- **CRP** - 共同复用原则 (Common Reuse Principle)

## 🎯 原则层次

```
类/对象层面
    ↓
  SOLID 原则
    ↓
组件/模块层面
    ↓
 REP/CCP/CRP
    ↓
系统架构层面
```

## 💡 学习路径

1. **初学者**: 从 SOLID 开始,特别是 SRP 和 DIP
2. **进阶**: 理解 OCP、LSP、ISP 的应用场景
3. **高级**: 掌握组件内聚原则,设计可维护的模块结构

## 🔗 原则关联

| 类级原则 | 组件级原则 | 关系 |
|---------|-----------|------|
| SRP (单一职责) | CCP (共同封闭) | CCP 是 SRP 在组件层的应用 |
| ISP (接口隔离) | CRP (共同复用) | CRP 是 ISP 在组件层的应用 |

## 📖 推荐阅读

- 《Clean Architecture》 - Robert C. Martin
- 《设计模式：可复用面向对象软件的基础》 - Gang of Four
- 《重构：改善既有代码的设计》 - Martin Fowler

## ⚠️ 注意事项

1. **不要过度设计**: 原则是指导,不是教条
2. **根据场景权衡**: 小项目可以适当简化
3. **持续重构**: 架构是演进的,不是一蹴而就的
4. **团队共识**: 确保团队对原则有共同理解

---

> "架构的目标是最小化构建和维护系统所需的人力资源。" - Robert C. Martin
