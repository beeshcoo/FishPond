# 定位地图 / 逆向索引 (Navigation)

> 放在 `<项目>/.fishpond/NAVIGATION.md`。**这是接手人最先看的"去哪找、去哪改"地图。**
> 目标：拿到一个功能名 / 一个报错 / 一条脏数据 / 一个字段，**30 秒内定位到具体代码、表、字段、接口**。
> 边开发边填；每加一个功能/接口/表/错误码就补一行。**任何一格空着 = 接手人会卡在这里。**

## 代码锚点约定（让 grep 秒到）
```
- 每个功能在其入口代码处留稳定锚点注释：  // [F-002] 创建订单
- 接口 handler、服务方法用领域名命名：      createOrder / OrderService.create
- 错误码用常量/枚举，全局唯一可 grep：      ORDER_ITEMS_EMPTY
- 于是："功能ID / 错误码 / 表名 / 接口路径" 任取其一，全局搜索即可跳到现场。
搜索示例： grep -rn "F-002"    grep -rn "ORDER_ITEMS_EMPTY"    grep -rn "orders"
```

## A. 主索引（功能 → 一切）
| 功能ID | 功能 | 接口(方法+路径) | 服务/模块 | 代码入口(文件:类/方法) | 主要表 | 关键字段 | 测试 | 错误码 |
|---|---|---|---|---|---|---|---|---|
| F-002 | 创建订单 | POST /api/v1/orders | order | src/order/OrderController::create → OrderService::create | orders, order_item | orders.status, orders.amount | order/OrderCreateTest | ORDER_ITEMS_EMPTY, COUPON_EXPIRED |

## B. 错误码 → 现场（"系统报了这个错，去哪改"）
| 错误码 | HTTP | 含义 | 抛出位置(文件:方法) | 触发条件 |
|---|---|---|---|---|
| ORDER_ITEMS_EMPTY | 400 | 订单无商品 | src/order/OrderService::create | items 为空 |
| COUPON_EXPIRED | 409 | 券过期 | src/coupon/CouponService::redeem | expires_at < now |

## C. 表/字段 → 用途（"这张表/这个字段谁在动，改它影响谁"）
| 表.字段 | 含义 | 被哪些功能/接口读写 | 代码位置(实体/迁移) |
|---|---|---|---|
| orders.status | 订单状态 | F-002 写, F-003 改 | src/order/Order 实体; V5__create_orders |
| app_user.password_hash | 密码哈希 | F-001 写/校验 | src/user/User 实体; V3__create_app_user |

## D. "我要找 X" 速查配方
```
找某功能的代码      → 在 NAVIGATION A 表查功能ID → grep 该 [F-xxx] 锚点
排查某报错          → 在 B 表查错误码 → 直达抛出位置 → 看触发条件
查某字段谁在改       → 在 C 表反查 → 定位实体与所有读写点
找某接口实现        → grep 路径关键字 或 handler 领域名（如 createOrder）
查某表结构          → 看 DATA_MODEL.md（字段/约束/注释）；改表加新迁移
数据出问题          → C 表定位字段 → B/A 表定位写入它的功能/接口 → 复现 → 修（配合 debug.md）
```

## E. 排障入口（现象 → 从哪下手）
| 现象 | 先看 | 再看 |
|---|---|---|
| 某接口报 5xx | 日志里的错误码/堆栈 → B 表定位 | 对应服务方法 |
| 某数据字段值不对 | C 表：谁写这个字段 | 该功能的写入逻辑 + 校验 |
| 某功能不工作 | A 表：功能ID → 代码入口 | 该模块测试是否覆盖此路径 |
| 启动失败 | HANDOFF 第 2 节 + LESSONS | 配置/依赖版本 |

## 维护规则
```
☐ 新增功能/接口/表/错误码 → 立刻补 A/B/C 表对应行
☐ 代码入口列必须是真实存在的文件与方法（写完 grep 验证一次）
☐ 交付前抽查 3 行：照着能否 30 秒定位到现场？不能 = 不合格
```
