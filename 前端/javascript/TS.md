# TypeScript

1. ReturnType
  获取函数返回值的类型

2. Partial
  省略对象的 key

3. keyof
  枚举对象的 key，高级用法

    ```
    type A = {
      name: string
      age: number
    }

    type B = {
      [key in keyof A]: A[key]
    }
    ```

4. Omit
  省去对象的某些 key

5. typeof
  得到数据对应 ts 声明

6. Awaited
  得到 Promise 值的类型

7. Required
  把非必要的参数转为必要

8. Pick
  只使用 interface 的某些 key

9. interface Box<T>
  interface 也可以使用泛型

10. interface readonly
  可通过 readonly 定义只读字段

11. type Box<T>
  type 也可以使用泛型

12. Conditional

    ```
    // 类似于三元运算符
    type Example1 = Dog extends Animal ? number : string;
    type Example1 = number
    ```

    ```
    // 多个类型一下很难写出来，但是多个会自动合并
    interface IdLabel {
      id: number /* some fields */;
    }
    interface NameLabel {
      name: string /* other fields */;
    }
    
    function createLabel(id: number): IdLabel;
    function createLabel(name: string): NameLabel;
    function createLabel(nameOrId: string | number): IdLabel | NameLabel;
    function createLabel(nameOrId: string | number): IdLabel | NameLabel {
      throw "unimplemented";
    }

    type NameOrId<T extends number | string> = T extends number ? IdLabel : NameLabel;
    ```


13. template
    ```
    type World = "world";
    type Greeting = `hello ${World}`;
    type Greeting = "hello world"

    type EmailLocaleIDs = "welcome_email" | "email_heading";
    type FooterLocaleIDs = "footer_title" | "footer_sendoff";
    type AllLocaleIDs = `${EmailLocaleIDs | FooterLocaleIDs}_id`;
    type AllLocaleIDs = "welcome_email_id" | "email_heading_id" | "footer_title_id" | "footer_sendoff_id"
    ```

14. const
  let a = 123 as const
  a = 2 // error

15. Record<Keys, Type>
  定义对象 Key 值，还有其对应的值的 type

16. Exculde
  type T = Exclude<"a" | "b" | "c", "a">
  type T = 'b' | 'c'

17. Extract
  type T0 = Extract<"a" | "b" | "c", "a" | "f">
  type T0 = "a"

  type T1 = Extract<string | number | (() => void), Function>
  type T1 = () => void

18. NonNullable
  type T0 = NonNullable<string | number | undefined>;
  type T0 = string | number

  type T1 = NonNullable<string[] | null | undefined>;
  type T1 = string[]

19. Parameters
  type T1 = Parameters<(s: string) => void>;
  type T1 = [s: string]

20. ConstructorParameters
  type T0 = ConstructorParameters<ErrorConstructor>;
  type T0 = [message?: string]

21. InstanceType
  相当于获取实例后的对象类型
  ```
  class C {
    x = 0;
    y = 0;
  }
  type T0 = InstanceType<typeof C>;
  type T0 = C
  ```

22. ThisParameterType
    ```
    function toHex(this: Number) {
      return this.toString(16);
    }
    
    function numberToString(n: ThisParameterType<typeof toHex>) {
      return toHex.apply(n);
    }
    ```

23. OmitThisParameter

24. ThisType


## TS Config

1. paths
  定义模块路径，类似 @xxx/xx