# 数据模型 (Data Model)

> 放在 `<项目>/.fishpond/DATA_MODEL.md`。**数据库真相源**：表/字段/类型/约束/注释与实际迁移和代码实体**逐字段一致**。
> 字段级细节写这里（ARCHITECTURE.md 只放表级概览）。改表 = 加新迁移，不改旧迁移。
> **改表零停机**：破坏性改动(改类型/改名/删列)用 expand-contract —— 先加新列→双写回填→读切换→(另一迁移)删旧列，分多步、每步可回退，别一把梭。

## 表清单速览
| 表 | 所属模块 | 说明 | 主键 | 关键外键 | 代码实体 | 迁移 |
|---|---|---|---|---|---|---|
| app_user | user-auth | 用户 | id | - | src/user/User | V3__create_app_user |
| orders | order | 订单 | id | fk_orders_user → app_user.id | src/order/Order | V5__create_orders |

> 「代码实体 / 迁移」两列必须真实存在，方便接手人从表直接跳到实体类与建表脚本（与 NAVIGATION.md 一致）。

---

## 表：app_user（用户）
| 字段 | 类型 | 约束 | 默认 | 注释 |
|---|---|---|---|---|
| id | UUID | PK | - | 主键 |
| username | VARCHAR(64) | NOT NULL UNIQUE | - | 登录名 |
| password_hash | VARCHAR(255) | NOT NULL | - | 密码哈希（禁止明文） |
| status | VARCHAR(16) | NOT NULL CHECK(ACTIVE/DISABLED) | 'ACTIVE' | 账号状态 |
| created_at | TIMESTAMPTZ | NOT NULL | now() | 创建时间 |
| updated_at | TIMESTAMPTZ | NOT NULL | now() | 更新时间 |
- 索引：`uk_app_user_username (username)`
- 迁移：`V<序号>__create_app_user`

## 表：orders（订单）
| 字段 | 类型 | 约束 | 默认 | 注释 |
|---|---|---|---|---|
| id | UUID | PK | - | 主键 |
| user_id | UUID | NOT NULL FK→app_user.id | - | 下单用户 |
| amount | DECIMAL(10,2) | NOT NULL CHECK(>0) | - | 金额 |
| status | VARCHAR(16) | NOT NULL | 'CREATED' | 订单状态 |
| created_at | TIMESTAMPTZ | NOT NULL | now() | 创建时间 |
| updated_at | TIMESTAMPTZ | NOT NULL | now() | 更新时间 |
- 索引：`idx_orders_user_status (user_id, status)`；外键：`fk_orders_user`
- 迁移：`V<序号>__create_orders`

## 交付前一致性自检
```
☐ 每张表/每个字段都与实际迁移脚本一致（名/型/约束/默认）？
☐ 代码实体(ORM)字段与本表一致？无"代码有、文档无"或反之？
☐ 每个外键都显式声明且命名 fk_<表>_<列>，并有索引？
☐ 每列都有注释？
```
