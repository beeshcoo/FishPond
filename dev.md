# FishPond · 标准化开发（dev）

> "用 FishPond 开发/新增/改造 X 模块"时按本文件执行。**任何语言/框架/数据库通用**，不锁定技术栈。
> 每个阶段以对应**资深角色**的清单把关（PM/架构/数据模型/大数据/后端/前端），见 [roles.md](roles.md)。

## Phase 0 · 圈鱼塘（每个新项目一次）

### 0.1 扫描识别技术栈
```
语言：pom.xml/build.gradle→Java；go.mod→Go；package.json→JS/TS；
      pyproject.toml/setup.py→Python；Cargo.toml→Rust；*.csproj→C#；composer.json→PHP；Gemfile→Ruby
构建：看各语言的锁文件/构建文件推断构建、测试、启动命令
框架：从依赖清单识别（后端 Web 框架 / 前端框架）
数据库：看迁移目录或配置里的连接串
模块化：包/目录/workspace/module 的组织方式
```

### 0.2 生成 `PROJECT_PROFILE.md` 并**验证命令**
用扫描结果填充 [templates/PROJECT_PROFILE.md](templates/PROJECT_PROFILE.md)。
**关键**：把推断出的 `<构建命令>`/`<测试命令>` **各真跑一次**，确认能成功执行，再写进画像。扫不准的字段标"待确认"并问人，**不要编**。（弱模型最常在这里填错，导致后续全错。）

### 0.3 装上真强制
生成 `.fishpond/verify.sh`（内含真实 构建+测试 命令）并安装 git pre-commit 钩子（见 [enforcement/pre-commit](enforcement/pre-commit) 与 [README.md](README.md)）。之后"测试不绿无法 commit"对任何 AI 生效。

### 0.4 建立/读取项目记忆层（解决跨会话"记忆"，也是交接文档）
`.fishpond/` 是项目外置大脑与文档真相源：`ARCHITECTURE.md`、`FEATURE_LIST.md`、`UI_UX.md`、`DATA_MODEL.md`、`API_SPEC.md`、`ROADMAP.md`、`TRACEABILITY.md`、`cards/`、`DEVLOG.md`、`LESSONS.md`、`CHANGELOG.md`、`PROJECT_PROFILE.md`、`verify.sh`（模板见 [templates/](templates/)）。
- 已存在 → **开工先读** `ARCHITECTURE` + `PROJECT_PROFILE` + `FEATURE_LIST` + 相关 `cards/` + `DEVLOG` + `LESSONS`，恢复全貌，别凭空臆测。
- 不存在 → 从计划模式产出（见 [SKILL.md 计划模式先行]）；新大项目走 [large-project.md](large-project.md)。

## Phase 1 · 模块定义卡片（动手前写完）

一模块=一张卡，存到 `.fishpond/cards/<模块名>.md`（标准模板 [templates/CARD.md](templates/CARD.md)）。卡片没写清或有歧义 → **停下来问，绝不猜**。
**大任务先分块**：先列出有序的卡片清单（被依赖的排前面），交人确认后一次只做一张，一张跑绿再开下一张。

```yaml
模块:
  名称: ""            # kebab-case，如 user-auth / order-payment
  中文名: ""
  类型: "新建 | 改造"
  目标路径: ""        # 该模块允许改动的目录，例：src/user/ 或 internal/order/ 或 packages/payment/
  优先级: "P0 | P1 | P2"

数据模型:
  新建表:
    - 名称: ""
      字段:
        - { 名: id,         型: <UUID/自增>, 约束: PK,        注: 主键 }
        - { 名: name,       型: <字符串>,    约束: NOT NULL,  注: 名称 }
        - { 名: status,     型: <枚举/字符串>,约束: CHECK(...), 注: 状态 }
        - { 名: created_at, 型: <时间戳>,    约束: NOT NULL,  注: 创建时间 }
        - { 名: updated_at, 型: <时间戳>,    约束: NOT NULL,  注: 更新时间 }
  修改表: []
  索引: [ "idx_xxx ON (col1, col2)" ]

API:
  协议: "REST | gRPC | GraphQL | RPC | WebSocket"
  基路径: "/api/v1/xxx"
  端点:
    - { 方法: GET, 路径: /xxx, 鉴权: "需认证|公开|管理员", 说明: 列表,
        请求: [ { 名: status, 型: string, 必填: false } ],
        响应: [ { 名: id }, { 名: name } ],
        错误: [ { 码: XXX_NOT_FOUND, HTTP: 404 } ] }

业务规则: []
验收标准:
  - [ ] 端点可访问且返回正确数据
  - [ ] 参数校验返回明确错误
  - [ ] 鉴权无效时拒绝访问
  - [ ] 现有测试未被破坏
  - [ ] 新增测试覆盖正常 + 异常路径
依赖模块: []
被依赖: []
迁移版本: "<下一个连续版本号>"
```

## Phase 2 · 开发（按固定顺序，减少漏层）
```
后端：数据迁移 → 模型/实体 → 仓库/DAO → DTO/schema → 服务 → 入口层(controller/handler/resolver)
前端：组件 → hook/store → 服务/API 调用
```
### 改表要零停机（expand-contract，防数据事故）
不要"直接改列类型/改名/删列"。分三步、每步可独立部署与回退：
```
1. Expand(扩)：加新列/新表(可空或带默认)，旧列保留；迁移只增不改。
2. Migrate(迁)：双写(新旧都写) + 回填历史数据 + 读切到新列，观察无误。
3. Contract(缩)：确认无人再用旧列后，另起一个迁移删除旧列。
```
> 绝不在一个迁移里"改类型/改名/删列 + 改代码"一把梭——那是停机与回滚地狱。

### 单模块执行者硬约束
```
1. 只在卡片"目标路径"内新建/改文件。
2. 严格按上面的文件顺序。
3. 不改其他模块；不改公共 API 签名（除非卡片授权）。
4. 不自行决定技术选型/索引/表结构（卡片没写就问）。
5. 每模块 ≥ 1 个集成测试（正常 + 异常）。
6. 不编造不存在的 API/表/配置；不谎称测试通过。
7. **充分注释**：公开接口/复杂逻辑必须注释（讲"为什么/约束/取舍"，不写废话）；命名用领域语言，方便他人接手。
8. 写代码的同时**同步更新** DATA_MODEL / API_SPEC / FEATURE_LIST（改哪块更哪块，别攒到最后）。
9. **边开发边写 `HANDOFF.md`**：装依赖/加配置/加启动步骤时，立刻把"亲自真跑验证过的命令"写进交接清单，别等交付前回忆（回忆=糊弄=别人跑不起来）。
10. **留代码锚点 + 补定位地图**：功能入口处写 `// [F-xxx]` 锚点注释，接口/服务用领域名命名，错误码用可 grep 的常量；同步补 `NAVIGATION.md`（功能↔接口↔服务↔表↔字段↔代码位置↔错误码）。目标：别人凭一个"功能ID / 报错码 / 表名 / 字段"就能 grep 直达现场。
```

## Phase 3 · 三道关（合入前，必须真跑）
1. **架构审查**：边界、依赖与卡片一致。
2. **测试验证**：真跑 `<构建命令> && <测试命令>`，**贴原始输出+退出码**；红了改到绿。
3. **契约校验**：代码逐条对照卡片。详见 [review.md](review.md)。

> 大型项目：还须满足 [large-project.md](large-project.md) 的完成定义(DoD 八条) + 更新追溯矩阵 + 过 CI 门禁。

## Phase 4 · 集成
按"依赖 → 被依赖"拓扑顺序合入；每合入一个跑一次全量回归。

## Phase 5 · 交付（对齐文档 + 保存记忆 + 交接就绪）
1. **更新真相源文档**：动了架构/边界/依赖→更 `ARCHITECTURE.md`；改了功能→更 `FEATURE_LIST.md`；动了表/字段→更 `DATA_MODEL.md`；动了接口→更 `API_SPEC.md`；动了界面→更 `UI_UX.md`。**不更不许交付。**
2. **0 误差一致性核对**：`FEATURE_LIST ↔ DATA_MODEL ↔ API_SPEC ↔ 实际代码` 四方逐条对齐，无"文档有代码无 / 代码有文档无"。（不一致 = 缺陷）
3. **产出清单**：API 变更清单 + 数据库变更清单 + 追加 `CHANGELOG.md`。
4. **写开发日志**：追加一条 `DEVLOG.md`（做了什么/为什么/验证/影响/下一步）。
5. **保存记忆**：更新受影响 `cards/`；踩坑追加 `LESSONS.md`。
6. **交接就绪**：`HANDOFF.md`（模板 [templates/HANDOFF.md](templates/HANDOFF.md)）全部填实、逐条命令**亲测有效**；最好找个没参与的人照它跑通一次。文末"交接确认清单"全绿才算交付。
