# 路线图 (Roadmap)

> 放在 `<项目>/.fishpond/ROADMAP.md`。计划模式产出，人确认后据此拆卡片、排顺序。

## 拆解层级
`Epic(史诗) → Feature(特性/功能ID) → Card(模块卡片) → Task`

## 路线图
| 顺序 | Epic | Feature(功能ID) | 卡片 | 依赖 | 优先级 | 状态 |
|---|---|---|---|---|---|---|
| 1 | 账户体系 | F-001 登录 | cards/user-auth.md | - | P0 | 待开发 |
| 2 | 交易 | F-002 创建订单 | cards/order.md | F-001 | P0 | 待开发 |

## 执行规则
```
- 被依赖的排前面（拓扑序）；一次只做一张卡，跑绿再下一张。
- 路线图变更需人确认；变更同步更新 FEATURE_LIST 与 TRACEABILITY。
```
