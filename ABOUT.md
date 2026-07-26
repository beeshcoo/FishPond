# RingPond 圈域 · About

> **Ring** = 圈定边界 · **Pond** = 专业域（鱼塘隐喻）· **圈域** = 一块精准可控、可交付、可交接的开发领地  
> 仓库：[github.com/beeshcoo/FishPond](https://github.com/beeshcoo/FishPond)（历史仓库名保留；技能品牌为 **RingPond 圈域**）

---

## 我们是谁

RingPond 圈域是一套 **AI 辅助开发的工程方法论 + Agent Skill 技能包**，不是又一个「帮你写代码的提示词」。

我们相信：

> 所有大模型都是一片太平洋；**圈域**要做的，是用纪律、文档、图谱和门禁，把 AI 圈进一块**你拍板的专业区域**里再执行——圈得越准，越不容易改崩、越不容易谎报、越能交给真人接手。

**语言无关 · 框架无关 · 模型无关**  
Java / Go / Python / Rust / Node / 任意前端 / 任意数据库——主流程零语言偏向。  
**新项目 · 已有项目** 均适用。

---

## 解决什么问题

| 痛点 | RingPond 怎么治 |
|---|---|
| AI 爱猜、爱谎报「测试过了」 | 真实跑命令 + 贴输出；pre-commit/CI **测试不绿提交不了** |
| 大项目一口吃、改一处坏全局 | **细卡片**分块 + 全局影响分析 + 全量回归 |
| 关电脑就忘、换会话就懵 | `.fishpond/` 外置记忆 + `SESSION_STATE.md` |
| 交接时无从下手 | `docs/` 交接总册 + `HANDOFF` + **CodeGraph 秒级定位** |
| UI 越改越丑 | **Taste** 进化型设计师，审美规则持续沉淀 |
| 规范停留在口号 | **Darwin** 训练式打分 → 低分变 `EVOLUTION` 补丁 → 规范越来越强 |
| 文档和代码两套皮 | **0 误差对齐**：功能清单 ↔ 数据模型 ↔ 接口 ↔ 图谱 ↔ 代码 |

---

## 三位一体（内嵌子技能）

RingPond v2 内嵌三个「会进化」的子能力，开发全程自动协同：

### Taste · 进化型设计师
- 定 UI/UX、设计系统、7 态齐全、无假成功
- 每次 UI 交付沉淀规则 → `.fishpond/TASTE_PROFILE.md`
- 详见 [embedded/taste.md](embedded/taste.md)

### CodeGraph · 系统知识图谱
- **故事地图** `STORY_MAP.md`：用户故事 → 主/支撑/分支/异常流
- **系统图谱** `SYSTEM_GRAPH.md`：模块/接口/表/中间件/页面的调用与读写关系
- 改代码 **同步更地图**，30 秒定位「改哪里」
- 详见 [embedded/codegraph.md](embedded/codegraph.md)

### Darwin · 技能进化训练
- 每张卡/每次会话 **Rubric 打分 0–20**
- 低分 → `.fishpond/EVOLUTION.md` 补丁 → 工程规范/Taste/审查清单变强
- 详见 [embedded/darwin.md](embedded/darwin.md)

---

## 十一项能力（完整系统落地）

1. **需求分析与方案落地** → `docs/SOLUTION.md` + 全套真相源  
2. **系统设计**（子域/责任区/技术决策）→ `ARCHITECTURE.md`  
3. **流程架构**（主/支撑/分支/异常，可导 Visio）→ `FLOW_ARCHITECTURE.md`  
4. **故事地图**（极细）→ `STORY_MAP.md`  
5. **系统知识图谱** → `SYSTEM_GRAPH.md`  
6. **docs 交接文档** → `docs/HANDOFF/`  
7. **交付 SOP** → `docs/SOP.md`  
8. **前端新手引导规格** → `docs/ONBOARDING.md`  
9. **Git 版本画像** → `GIT_PROFILE.md`（**不含 token**）  
10. **跨会话记忆** → `SESSION_STATE.md` + DEVLOG  
11. **工程规范进化** → `docs/ENGINEERING_CHARTER.md` + Darwin  

---

## 资深团队身份（加载即入戏）

RingPond 加载后，AI 以六顶资深帽子协作（详见 [roles.md](roles.md)）：

高级项目经理 · 高级架构师 · 高级数据模型架构师 · 高级大数据架构师（按需）· 高级后端工程师 · 高级前端工程师

共同底线：**不臆测、要证据、真实跑、如实报、顾全局、可交接。**

---

## 诚实边界（我们不吹牛）

- **不能保证字面意义「零 bug」**；我们保证的是 **零缺陷逃逸**——没被测试和门禁发现的 bug 不允许进主干。
- 记忆层/图谱/角色的**更新**目前主要靠流程约束；**机器强制**集中在 git pre-commit + CI。
- 技能需在真实项目里跑通验证；首次落地请按 [TUTORIAL.md](TUTORIAL.md) 做一遍。

---

## 与 FishPond 的关系

- **FishPond** = 早期内部代号（鱼塘 / 圈鱼塘）。
- **RingPond 圈域** = 正式品牌名（v2.0+），能力完全包含并扩展 FishPond。
- 触发词 **FishPond / RingPond / 圈域 / 圈鱼塘** 均可加载本技能。
- 安装目录推荐：`~/.claude/skills/ringpond/`（兼容旧目录 `fishpond/`）。

---

## 文档导航

| 文档 | 用途 |
|---|---|
| [TUTORIAL.md](TUTORIAL.md) | **非常详细的完整教程（建议精读）** |
| [QUICKSTART.md](QUICKSTART.md) | 5 分钟极速上手 |
| [USAGE.md](USAGE.md) | 使用指南与话术速查 |
| [INDEX.md](INDEX.md) | 全文件索引 |
| [README.md](README.md) | 安装与仓库说明 |

---

## 许可证

MIT · 见 [LICENSE](LICENSE)
