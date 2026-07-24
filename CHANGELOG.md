# FishPond 技能 · 变更记录

遵循语义化版本（大版本.功能.修订）。

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
