# TypeScript

1. ReturnType
  获取函数返回值的类型

2. Partial
  省略对象的 key

3. keyof
  枚举对象的 key

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