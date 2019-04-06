
    1.在express创建的项目文件里面装 sequelize (npm i sequelize)
    2.npm i mysql2
    3.npm i ejs

    4.创建一个db文件夹  里面先弄配置文件
    5.然后就可以创建我们的js文件


    https://www.jianshu.com/p/ebf317311ed7     语句的格式网站

    一些用法
    operatorsAliases开启之后就可以用自定义的东西了

//timestamp字段表示数据库中是否会自动更新createdAt和updatedAt字段，false表示不会增加这个字段。
freezeTableName为false表示该模型对应的表明就为students表，默认时为true，对应表名为student


    // where: sequelize.or({//这个是或者的写法  里面都是或者的关系
//     id:1,
//     name:'1121'
// })
// where: sequelize.and({//这个是并且的另一种写法  里面都是并且的关系
//     id:1,
//     name:'1121'
// })
// where:{
//     [sequelize.Op.and]:{//写and 是and  写 or 是 or
//         id:1,
//         name:'sss',
//     }
// }

// where:{//这种写法  where对象里面的评级对象都是and的关系 然后数组对象里面是根据自己写的 or 或者 and 的关系
//     [sequelize.Op.and]:{//
//         id:1,
//         name:'sss',
//     },[sequelize.Op.or]:{//
//         sex:'aaa',
//     }
// }

// Student.create({//添加的方法
//     name:'aaa',
//     sex: '1',
// 	brithday:'96',
// 	phone:'11111111111',
// 	adress:'22222222222',
// 	grade:'999999',
// }).then(function(res){
//     console.log(JSON.stringify(res));
// });

//更新 只要把 create 替换成update
//删除 只要把 findAll 替换成destory
// 这俩里面的条件格式和上面一样

    var countPerPage = 20, currentPage = 5;
    var users = yield User.findAll({
    ‘limit‘: countPerPage,                      // 每页多少条
    ‘offset‘: countPerPage * (currentPage - 1)  // 跳过多少条
    });

    这也是两种查法
    user = yield User.findById(1);
    user = yield User.findOne({
    ‘where‘: {‘nick‘: ‘a‘}
    });

    这个和findAll差不多，只是顺便还查到所有数据的数量
    findAndCountAll

    下面这种批量也可以操作
    var users = yield User.bulkCreate(
    [
        {‘emp_id‘: ‘a‘, ‘nick‘: ‘a‘},
        {‘emp_id‘: ‘b‘, ‘nick‘: ‘b‘},
        {‘emp_id‘: ‘c‘, ‘nick‘: ‘c‘}
    ]
    );

    //这种就是查出来age字段最大的值，不是一整条数据
    User.max('age')

    //像下面这种，include里面有where条件，查询条件就会变成 inner   如果没有就是 left outer 以左表为主表
    User.findAll({
    include:[{
        model:yo,
        where:{
            id:1
        }
    }],where:{这个是主表的where条件，
        id:1
    }
    })


    下面这个include条件后面写一个order这些就是可以让按什么倒序
    User.findAll({
    include:[{
        model:yo,
    }],order: [ [ { model: yo, as: 'Div' }, 'name' ,'desc'] ]
    })  

    也支持数组（二维数组）格式：
    User.findAll({order:[['id', DESC]]});
    如果使用连接模型字段排序，就要向排序数组中传入3个值：
    User.findAll({ include:[ Player ], order:[[Player, 'id', DESC]]});

    下面这种就是一个简单的的三表联查
    User.belongsTo(yo,{foreignKey:'id',targetKey: 'age'});
    yo.belongsTo(snc,{foreignKey:'id',targetKey: 'id'});
    User.findAll({
      'include':[{
          'model':yo,
          include:[{
              model:snc
          }]
      }]
    })
    语句是这样的
    SELECT `tab_user`.`id`, `tab_user`.`username`, `tab_user`.`password`, `tab_user`.`yoId`, `yo`.`id` AS `yo.id`, `yo`.`sex` AS `yo.sex`, `yo`.`age` AS `yo.age`, `yo->snc`.`id` AS `yo.snc.id`, `yo->snc`.`body` AS `yo.snc.body` FROM `tab_user` AS `tab_user` LEFT OUTER JOIN `yo` AS `yo` ON `tab_user`.`id` = `yo`.`age` LEFT OUTER JOIN `snc` AS `yo->snc` ON `yo`.`id` = `yo->snc`.`id`;

    //这种是要指定的字段
    User.belongsTo(yo,{foreignKey:'age',targetKey: 'age'});
    yo.belongsTo(snc,{foreignKey:'id',targetKey: 'id'});
    User.findAll({
    attributes:['username'],这里面写字段的名称就行了
      'include':[{
          'model':yo,
          attributes:['sex']  同上
      }],
      })

    