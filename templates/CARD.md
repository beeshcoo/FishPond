# 模块卡片：<模块名>

> 存 `<项目>/.fishpond/cards/<模块名>.md`。动手前写完，有歧义**停下来问，绝不猜**。
> 一张卡 = 一个可独立测试的模块/特性；大任务拆成多张，被依赖的排前面。

```yaml
模块:
  名称: ""            # kebab-case，如 user-auth / order-payment
  中文名: ""
  类型: "新建 | 改造"
  目标路径: ""        # 只允许改动的目录，例 src/user/ 或 internal/order/
  功能ID: ""          # 对应 FEATURE_LIST 的 F-xxx
  优先级: "P0 | P1 | P2"

数据模型:
  新建表:
    - 名称: ""
      字段:
        - { 名: id,         型: <UUID/自增>, 约束: PK,        注: 主键 }
        - { 名: created_at, 型: <时间戳>,    约束: NOT NULL,  注: 创建时间 }
        - { 名: updated_at, 型: <时间戳>,    约束: NOT NULL,  注: 更新时间 }
  修改表: []            # 改造旧项目时填写；破坏性改动用 expand-contract
  索引: [ "idx_xxx ON (col1, col2)" ]

API:
  协议: "REST | gRPC | GraphQL | RPC | WebSocket"
  基路径: "/api/v1/xxx"
  端点:
    - { 方法: GET,  路径: /xxx, 鉴权: "需认证|公开|管理员", 说明: 列表,
        请求: [ { 名: status, 型: string, 必填: false } ],
        响应: [ { 名: id }, { 名: name } ],
        错误: [ { 码: XXX_NOT_FOUND, HTTP: 404 } ] }

UI:                     # 有前端时填写；无则删本节
  页面: [ "页面名 → 路由" ]
  必须覆盖状态: [ 正常, 加载, 空, 错误, 无权限, 超长, 响应式 ]

业务规则:
  - ""

全局影响分析:          # 改一块也顾全局
  引用点: [ "哪些模块/接口/表会受影响" ]
  回归范围: [ "改完必须跑哪些测试/模块" ]

验收标准:
  - [ ] 端点可访问且返回正确数据
  - [ ] 参数校验返回明确错误
  - [ ] 鉴权无效时拒绝访问（服务端强制，不是藏按钮）
  - [ ] 正常 + 异常 + 边界 三类路径有自动化测试，真实跑绿
  - [ ] 现有测试未被破坏（全量回归绿）
  - [ ] FEATURE_LIST / DATA_MODEL / API_SPEC / NAVIGATION 已同步
  - [ ] 代码入口有 // [F-xxx] 锚点；错误码可 grep

依赖模块: []
被依赖: []
迁移版本: "V<下一个连续号>"

状态: "待确认 | 开发中 | 已完成"
```

## 卡片完成后必须同步
- 更新 `FEATURE_LIST.md`、`DATA_MODEL.md`、`API_SPEC.md`、`NAVIGATION.md`
- 追加 `DEVLOG.md`；交付时更新 `HANDOFF.md`
