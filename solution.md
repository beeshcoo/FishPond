# FishPond · 需求分析与方案落地（Solution Landing）

> 对应需求 **#1**：从需求到**完整系统方案**的一次性落地文档——架构、功能、UI/UX、前端、后端、数据库、数据模型、表、接口、字段等**全部写清、人确认后再开发**。
> **语言无关**；适用于新项目与已有项目的新大特性。

## 何时进入
- 新项目启动（large-project 第 0 步之后）
- 已有项目的新 Epic/大特性（先圈范围，再走本流程）
- 触发语：`用 FishPond 做需求分析与方案落地` / `出完整系统方案`

## 产出物（一次方案 = 一套真相源，存 `.fishpond/` + `docs/`）
| 文档 | 内容 |
|---|---|
| `docs/SOLUTION.md` | **本文件产出**：需求摘要+完整方案总览（给人审） |
| `ARCHITECTURE.md` | 总架构、子域、模块、依赖、服务清单 |
| `FEATURE_LIST.md` | 功能清单（F-xxx） |
| `UI_UX.md` | 页面/交互/7态（Taste 参与） |
| `DATA_MODEL.md` | 表/字段/约束/索引 |
| `API_SPEC.md` | 接口/服务/错误码/鉴权 |
| `STORY_MAP.md` | 用户故事+流程（CodeGraph） |
| `SYSTEM_GRAPH.md` | 系统知识图谱骨架（CodeGraph） |
| `FLOW_ARCHITECTURE.md` | 主/支撑/分支/异常流程图 |
| `ROADMAP.md` | 拆块路线图 |

## 六步流程

### Step 1 · 需求澄清（只问不写码）
与人对齐并写入 `docs/SOLUTION.md`：
- 目标用户、核心场景、边界（做/不做）
- 非功能：性能、安全、合规、可用性、数据量
- 约束：技术栈、交付时间、团队、遗留系统

### Step 2 · 方案总览（一张图说清系统）
在 `docs/SOLUTION.md` 写：
- 一句话定位
- 子域划分（见 [system-design.md](system-design.md)）
- 技术选型与理由（ADR 摘要）
- 外部依赖（中间件、第三方）

### Step 3 · 分层方案（逐层写实，禁止"待定"糊弄）
```
业务层：FEATURE_LIST + STORY_MAP（故事与流程）
应用层：ARCHITECTURE 模块 + API_SPEC 服务
数据层：DATA_MODEL 表字段
表现层：UI_UX 页面 + Taste 审查要点
集成层：中间件/消息/缓存（写入 SYSTEM_GRAPH MW- 节点）
```

### Step 4 · 一致性自检（0 误差预检）
```
☐ 每个 F-xxx 在 STORY_MAP 有故事、在 API_SPEC 有接口、在 DATA_MODEL 有表
☐ 每个 API 有鉴权、错误码、关联功能 ID
☐ 每个页面在 UI_UX 有 7 态说明
☐ SYSTEM_GRAPH 骨架节点覆盖所有 MOD/API/TBL/MW
```

### Step 5 · 人确认签字
**人确认前禁止写业务代码。** 确认后拆 ROADMAP + 模块卡片。

### Step 6 · Darwin 记录
方案评审后打 Darwin 分（方案完整性维度），低分项写入 EVOLUTION。

## docs/SOLUTION.md 模板结构
见 [templates/docs/SOLUTION.md](../templates/docs/SOLUTION.md)
