# FishPond · 填好的范例

> 给弱模型看"长什么样才算合格"。这些是**格式样例**，不是要你照抄内容。

## 范例 1 · 一张填好的模块卡片（以"优惠券"模块为例，语言无关）

```yaml
模块:
  名称: "coupon"
  中文名: "优惠券"
  类型: "新建"
  目标路径: "src/coupon/"      # 只允许改这个目录
  优先级: "P1"

数据模型:
  新建表:
    - 名称: coupon
      字段:
        - { 名: id,          型: UUID,        约束: PK,                     注: 主键 }
        - { 名: code,        型: VARCHAR(32), 约束: NOT NULL UNIQUE,        注: 券码 }
        - { 名: amount,      型: DECIMAL(10,2),约束: NOT NULL CHECK(>0),     注: 面额 }
        - { 名: status,      型: VARCHAR(16), 约束: CHECK(ACTIVE/USED/EXPIRED), 注: 状态 }
        - { 名: expires_at,  型: TIMESTAMPTZ, 约束: NOT NULL,               注: 过期时间 }
        - { 名: created_at,  型: TIMESTAMPTZ, 约束: NOT NULL,               注: 创建时间 }
        - { 名: updated_at,  型: TIMESTAMPTZ, 约束: NOT NULL,               注: 更新时间 }
  索引: [ "idx_coupon_status_expires ON (status, expires_at)" ]

API:
  协议: "REST"
  基路径: "/api/v1/coupons"
  端点:
    - { 方法: POST, 路径: /, 鉴权: 管理员, 说明: 创建优惠券,
        请求: [ {名: code, 型: string, 必填: true}, {名: amount, 型: number, 必填: true},
                {名: expiresAt, 型: string, 必填: true} ],
        响应: [ {名: id}, {名: code}, {名: status} ],
        错误: [ {码: COUPON_CODE_DUPLICATE, HTTP: 409} ] }
    - { 方法: POST, 路径: /{id}/redeem, 鉴权: 需认证, 说明: 核销,
        错误: [ {码: COUPON_NOT_FOUND, HTTP:404}, {码: COUPON_ALREADY_USED, HTTP:409},
                {码: COUPON_EXPIRED, HTTP:409} ] }

业务规则:
  - 券码全局唯一，大小写不敏感
  - 核销时校验 status=ACTIVE 且 expires_at>now，否则报对应错误码
  - 核销成功后 status 置 USED（同一事务，防并发重复核销）
验收标准:
  - [ ] 创建重复券码返回 409 COUPON_CODE_DUPLICATE
  - [ ] 核销过期券返回 409 COUPON_EXPIRED
  - [ ] 并发核销同一券只成功一次
  - [ ] 非管理员创建被拒
依赖模块: [ "user-auth(鉴权)" ]
被依赖: [ "order(下单抵扣)" ]
迁移版本: "V<下一个连续号>"
```

## 范例 2 · 一份合格的审查报告

```markdown
# 审查报告：coupon
## 必须修复（阻断合入）
- [ ] 第14项：redeem 未加事务，并发下会重复核销。src/coupon/service.xxx:42 —— 包裹事务并对 status 做条件更新(乐观锁)。
- [ ] 第16项：测试里写死了管理员密码。src/coupon/xxx_test:18 —— 改用测试夹具/环境变量。
## 建议改进（不阻断）
- [ ] 第11项：expires_at 常用于过滤，建议确认 idx_coupon_status_expires 已生效。
## 合规通过
- ✅ 第 1,2,4,5,6,7,8,9,10,12,13,15,17,18 项
## 判定：❌ 2 项阻断 → 修正后复审
```

## 范例 3 · 一份合格的生产诊断报告

```markdown
### 现象：核销接口从 09:12 起大量返回 500
### 直接原因：service.xxx:42 空指针——coupon 为 null 时未判空
### 根因(5 Whys)：
  为何500→NPE；为何NPE→按 code 查不到；为何查不到→前端传了带空格的 code；
  为何带空格→输入框未 trim；为何没 trim→缺输入规范化。根因=服务端未规范化入参。
### 影响数据：09:12–09:40 共 1,203 次失败请求，0 条脏数据写入
### 修复方案：
  止血：临时在网关对 code 做 trim（不需部署，2 分钟，可回退）
  治本：service 入口规范化 + 加判空返回 404 COUPON_NOT_FOUND + 补测试
  全局影响：不影响其他模块 / 响应格式不变 / 无脏数据 / 前端无需改 / 无性能影响
```
