# FishPond 技能 · 变更记录

遵循语义化版本（大版本.功能.修订）。

## v2.1.0 — 2026-07-26
**品牌重塑为 RingPond 圈域** + About + 超详细教程

- 正式品牌：**RingPond（圈域）**；`name: ringpond`；兼容 FishPond/圈鱼塘 触发词
- 新增 [ABOUT.md](ABOUT.md)：使命、三位一体、十一项能力、诚实边界、与 FishPond 关系
- 新增 [TUTORIAL.md](TUTORIAL.md)：11 篇完整教程（安装/新项目/旧项目/三位一体/记忆/Git/docs/实验/FAQ）
- 安装目录改为 `ringpond/`；README/QUICKSTART/INDEX 全面更新

## v2.0.0 — 2026-07-26
**三位一体 + 十一项能力全面封装** — Taste / CodeGraph / Darwin 内嵌；新项目与旧项目通用；语言无关。

**内嵌子技能**
- [embedded/taste.md](embedded/taste.md)：进化型设计师，TASTE_PROFILE 深造
- [embedded/codegraph.md](embedded/codegraph.md)：STORY_MAP + SYSTEM_GRAPH 知识图谱
- [embedded/darwin.md](embedded/darwin.md)：训练式打分 0–20，EVOLUTION 技能进化

**新增流程与模板**
- [solution.md](solution.md)、[system-design.md](system-design.md)
- STORY_MAP / SYSTEM_GRAPH / FLOW_ARCHITECTURE / TASTE_PROFILE / DARWIN_SCORES / EVOLUTION / GIT_PROFILE / SESSION_STATE
- `docs/`：SOLUTION / SOP / ONBOARDING / ENGINEERING_CHARTER / HANDOFF
- [setup-git.ps1](setup-git.ps1)：Git 画像（无 token）
- init-project v2：一次初始化 `.fishpond/` + `docs/` 全套

## v1.1.0 — 2026-07-26
**全面版补全**——安装、使用、旧项目、初始化一条龙。

**新增**
- [QUICKSTART.md](QUICKSTART.md)：5 分钟快速上手（安装→初始化→触发语→把关三件事）。
- [INDEX.md](INDEX.md)：完整文件索引（人看/机器加载/模板/门禁/场景路由）。
- [brownfield.md](brownfield.md)：旧项目/棕地专册（测绘→拆细块→表征测试→绞杀者替换）。
- [init-project.ps1](init-project.ps1) / [init-project.sh](init-project.sh)：一键初始化目标项目 `.fishpond/` 全套文档 + pre-commit 门禁。
- 模板：`templates/CARD.md`（模块卡片标准）、`LESSONS.md`、`CHANGELOG.project.md`（项目交付记录）。
- `.gitignore`；`install` 排除 `.git` 避免污染技能目录。

**增强**
- `SKILL.md` frontmatter 扩展触发词（旧项目、拆细块、交接、计划模式等）。
- `dev.md` 引用 CARD 标准模板。

## v1.0.0 — 2026-07-24
首个可发布版本。语言无关、模型无关（Claude Code 接 DeepSeek / 任意模型），符合 Agent Skills 开放格式。

**方法论**
- 三种模式：结构化开发（dev）、代码审查（review）、生产排查（debug）+ 大型项目模式（large-project）。
- 六顶资深帽子（roles）：PM / 架构 / 数据模型 / 大数据 / 后端 / 前端，各带把关清单。
- 计划模式先行、分块处理（隔离爆炸半径 + 改一块顾全局）、任务分级轻量逃生口。

**可交接 / 可定位（针对"接手无从下手"）**
- 项目记忆层 `.fishpond/`：ARCHITECTURE / FEATURE_LIST / UI_UX / DATA_MODEL / API_SPEC / ROADMAP / TRACEABILITY / NAVIGATION / cards / HANDOFF / DEVLOG / LESSONS / CHANGELOG。
- HANDOFF 交接清单（边开发边写、命令亲测有效）+ NAVIGATION 定位地图 + 代码锚点，凭功能名/报错/表名/字段 30 秒定位到现场。
- 文档↔代码 0 误差一致性门禁；充分注释铁律。

**真强制（不靠模型自觉）**
- 跨平台 verify：`verify.example.sh` / `verify.example.ps1`；`pre-commit` 自动择一，测试不绿/覆盖率不达标无法 commit。
- CI 门禁模板 `ci.example.yml` + 覆盖率阈值；本地 pre-commit + CI 双层拦截。
- Claude Code 权限护栏 `settings.example.json`（含 PowerShell 危险命令形态）。
- expand-contract 零停机改表规范。

**发布**
- MIT LICENSE；`install.ps1` / `install.sh` 一键安装到 Claude Code / Cursor 并给项目装门禁。

### 已知限制（诚实记录）
- 尚未在真实项目端到端跑验证过（install/pre-commit/CI 链需你首次落地时确认）。
- 记忆层、角色、导航的更新仍主要靠指令约束；机器强制目前集中在 commit/CI 门禁。
- 示例内容偏通用 OOP 命名，落地时按本项目技术栈替换。
