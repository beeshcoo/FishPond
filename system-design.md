# FishPond · 系统设计（子域 / 流程 / 故事地图）

> 对应需求 **#2 #3 #4**：确认子域与业务责任区、梳理主/支撑/分支/异常流程、生成故事地图与流程架构（可导出 Visio/ draw.io 的 mermaid 源）。
> 与 [embedded/codegraph.md](embedded/codegraph.md) 紧密联动。

## 第 1 部分 · 子域与业务责任区（需求 #2）

在 `ARCHITECTURE.md` 写清：

| 子域 | 业务责任 | 核心实体 | 对外接口前缀 | 依赖子域 | 负责人 |
|---|---|---|---|---|---|
| 身份与访问 | 登录/鉴权/组织 | User, Role | /api/v1/auth | - | |
| 审批 | 流程实例/任务 | ApprovalInstance | /api/v1/approvals | 身份 | |

**规则**：
- 一个子域 = 一个模块边界（代码目录与 MOD- 节点一一对应）
- 跨子域只走声明 API/事件，不直接访问对方表
- 关键业务信息（状态机、金额规则、权限模型）写进子域小节

**默认技术决策策略**（可覆盖，覆盖须写 ADR）：
```
鉴权：服务端强制，不单靠前端隐藏
数据：关系库+迁移工具；改表 expand-contract
API：REST 名词复数；错误码统一
前端：设计系统+token；7态齐全
缓存：先查后写；写路径考虑失效
```

## 第 2 部分 · 流程架构（需求 #3）

在 `.fishpond/FLOW_ARCHITECTURE.md` 为每个**核心业务能力**画四类流：

| 流类型 | 说明 | 必须画 |
|---|---|---|
| 主流程 | 用户完成核心任务 happy path | ✅ |
| 支撑流 | 鉴权/通知/审计/配置等横切 | ✅ |
| 分支流 | 条件分支（如金额>阈值走并行审批） | 有则必画 |
| 异常流 | 失败/超时/拒绝/回滚 | ✅ |

**格式**：mermaid `flowchart` 或 `sequenceDiagram`（可粘贴到 Visio/draw.io 的 mermaid 插件或导出 SVG）。

示例见 [templates/FLOW_ARCHITECTURE.md](../templates/FLOW_ARCHITECTURE.md)。

## 第 3 部分 · 故事地图（需求 #4）

在 `.fishpond/STORY_MAP.md`：

```
史诗(Epic) → 用户故事(ST-xxx) → 主/支撑/分支/异常流 → 功能(F-xxx) → 页面(PG) → API → 表(TBL)
```

每张故事卡片字段：
- 故事 ID、角色、想要、以便
- 关联流程（链接 FLOW_ARCHITECTURE 章节）
- 关联 SYSTEM_GRAPH 节点 ID
- 验收标准（可测试）

**粒度**：故事要细——一个用户可感知的小能力一条 ST，便于拆卡片与图谱分块。

## 维护铁律
```
流程变 → 更 FLOW_ARCHITECTURE + STORY_MAP + SYSTEM_GRAPH（同一 commit）
新模块 → ARCHITECTURE 子域表 + SYSTEM_GRAPH MOD 节点
```

## 与开发的关系
开发按 **ROADMAP 卡片** 顺序进行，每张卡必须声明：
- 实现哪些 ST-xxx / F-xxx
- 涉及哪些流程段
- 在 SYSTEM_GRAPH 中新增/修改哪些节点与边
