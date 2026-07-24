# 功能清单 (Feature List)

> 放在 `<项目>/.fishpond/FEATURE_LIST.md`。**功能真相源**：功能一增/改/删，必须同步更新本表，否则视为未完成。
> 每条功能有唯一 ID，可与 TRACEABILITY.md 的需求 ID、cards/ 的卡片对应。

## 状态图例
`规划中` · `开发中` · `已完成` · `已上线` · `已废弃`

## 功能清单
| 功能ID | 所属模块 | 功能名称 | 描述(用户能做什么) | 关联接口(API_SPEC) | 关联表(DATA_MODEL) | 代码入口(文件:方法) | 权限/角色 | 卡片 | 状态 |
|---|---|---|---|---|---|---|---|---|---|
| F-001 | user-auth | 登录 | 用户用账号密码登录 | POST /auth/login | app_user | src/user/AuthController::login | 公开 | cards/user-auth.md | 已完成 |
| F-002 | order | 创建订单 | 选商品下单 | POST /orders | orders,order_item | src/order/OrderController::create | 需认证 | cards/order.md | 开发中 |

> 「代码入口」列必须是真实存在的文件+方法，且方法处有 `// [F-xxx]` 锚点注释，方便 grep 直达（与 NAVIGATION.md 一致）。

## 变更记录（功能一改就在此追加）
| 日期 | 变更类型(增/改/删) | 功能ID | 说明 | 影响的接口/表 |
|---|---|---|---|---|
| 2026-0x | 增 | F-002 | 新增创建订单 | +POST /orders, +表 orders |

## 交付前自检
```
☐ 每条"已完成/已上线"功能都能在代码里找到对应实现与测试？
☐ 每条功能的"关联接口/关联表"都与 API_SPEC.md / DATA_MODEL.md 一致？
☐ 有没有代码里存在、但清单里查不到的"影子功能"？（有=补登记）
```
