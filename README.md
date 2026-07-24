# FishPond 技能包

把大模型"圈"成一小块精准可控的专业区域再执行。**语言无关、框架无关、模型无关**——在 Claude Code（可接 DeepSeek / 任意模型）、Cursor 等支持 Agent Skills 的工具里都能用。

> 📖 **不知道怎么用？先读 [USAGE.md](USAGE.md)** —— 非常详细的手把手教程，含"从零做完一个报销系统"的完整演练。

## 这是什么

一个符合 **Agent Skills 开放格式**（`SKILL.md` + YAML frontmatter）的技能包。任何遵循该格式的 AI 工具，只要把本文件夹放进它的技能目录，就能自动发现并按需加载。

```
fishpond/
├── SKILL.md            # 入口：身份 + 心法 + 路由（工具优先加载它）
├── USAGE.md            # ⭐ 非常详细的使用指南（含从零到交付的实战演练）—— 先读这个
├── roles.md            # 六顶资深帽子：PM/架构/数据模型/大数据/后端/前端 及各自把关清单
├── dev.md              # 结构化开发（Phase 0→5，单模块）
├── large-project.md    # 大型项目模式（史诗拆解/契约先行/追溯/DoD/双层门禁/发布）
├── review.md           # 代码审查清单（通用 + 各语言附录）
├── debug.md            # 生产排查协议
├── examples.md         # 填好的范例（卡片/审查报告/诊断报告）
├── templates/              # 项目文档真相源模板（拷进 <项目>/.fishpond/ 使用）
│   ├── PROJECT_PROFILE.md   # 技术栈 + 构建/测试命令
│   ├── ARCHITECTURE.md      # 总架构（架构一变必更）
│   ├── FEATURE_LIST.md      # 功能清单（功能一改必更）
│   ├── DATA_MODEL.md        # 数据库表 + 字段（与代码一致）
│   ├── API_SPEC.md          # 接口 + 服务清单（与代码一致）
│   ├── UI_UX.md             # UI/UX 规格
│   ├── ROADMAP.md           # 史诗→特性→卡片路线图
│   ├── TRACEABILITY.md      # 需求追溯矩阵（零需求遗漏）
│   ├── NAVIGATION.md        # 定位地图（功能↔接口↔表↔字段↔代码↔错误码，出问题去哪改）
│   ├── DEVLOG.md            # 开发日志
│   └── HANDOFF.md           # 交接清单（边开发边写，新人照此直接上手）
├── enforcement/
│   ├── pre-commit           # git 门禁：测试不绿/覆盖率不达标不许 commit（自动择 sh/ps1）
│   ├── verify.example.sh    # 构建+测试+覆盖率 聚合脚本（POSIX 起始模板）
│   ├── verify.example.ps1   # 同上（PowerShell/Windows 起始模板）
│   ├── ci.example.yml       # CI 门禁模板（GitHub Actions，PR 不绿不能合并）
│   └── settings.example.json# Claude Code 真实权限护栏（含 PowerShell 危险命令形态）
├── install.ps1 / install.sh # 一键安装到任意工具的技能目录 + 给项目装门禁
├── LICENSE                  # MIT
├── CHANGELOG.md             # 版本记录（当前 v1.0.0）
└── README.md
```

## 安装

### 方式 A：一键脚本（推荐）
```powershell
# Windows / Claude Code（默认）
./install.ps1
# 装进 Cursor / 两个都装
./install.ps1 -Target cursor      # 或 -Target both
# 顺便给某项目装上 git 测试门禁
./install.ps1 -Project C:\path\to\project
```
```bash
# macOS / Linux
./install.sh            # claude（默认）
./install.sh both       # claude + cursor
./install.sh claude /path/to/project
```

### 方式 B：手动放置
把整个 `fishpond/` 文件夹复制到：
- Claude Code：`~/.claude/skills/fishpond/`（用户级）或 `<项目>/.claude/skills/fishpond/`（项目级）
- Cursor：`~/.cursor/skills/fishpond/`

重启工具后，说"用 FishPond 开发 X 模块 / 审查这段代码 / 帮我排查线上问题"即可触发。

## 让"所有 AI 都能查找安装"

1. 把本文件夹作为独立仓库推到 GitHub（如 `beeshcoo/FishPond`）。
2. 任何人（或任何能执行命令的 AI agent）都可以：
   ```bash
   git clone https://github.com/beeshcoo/FishPond.git
   cd FishPond && ./install.sh        # 或 install.ps1
   ```
3. 因为用的是标准 `SKILL.md` frontmatter，安装后 Claude Code / Cursor 等会**自动发现**并在匹配到触发词时加载——无需手动配置。

> 说明：目前没有"全 AI 统一注册中心"。跨工具通用的现实做法就是：**开放格式 + 公共 Git 仓库 + 安装脚本**。本包三者齐备。

## 真强制（不靠模型自觉）

- `enforcement/pre-commit`：装到项目后，**构建/测试不通过或覆盖率不达标就无法 commit**，对 DeepSeek、Claude、人类一视同仁；自动识别 `verify.ps1`(PowerShell) 或 `verify.sh`(POSIX)。
- `.fishpond/verify.(sh|ps1)`：Phase 0 按 `PROJECT_PROFILE` 生成，内含真实"构建 && 测试(含覆盖率阈值)"命令，是门禁判定依据（模板 `enforcement/verify.example.*`）。
- `enforcement/ci.example.yml`：CI 第二道门禁，PR 不绿不能合并（配合分支保护）。**本地 pre-commit + CI = 双层拦截。**
- `enforcement/settings.example.json`：Claude Code 工具层真实拦截 `rm -rf` / `reset --hard` / `push --force`（含 PowerShell 形态）。

> 版本 v1.0.0，含诚实的「已知限制」清单，见 [CHANGELOG.md](CHANGELOG.md)。

## 项目记忆层（跨会话"记忆"的解法）

模型不跨会话记忆，所以每个项目根下建一个 `.fishpond/` 当"外置大脑"，会话开工先读、收工必写：

```
<项目>/.fishpond/
├── PROJECT_PROFILE.md  技术栈 + 构建/测试命令
├── ARCHITECTURE.md     总架构（架构一变必更）
├── FEATURE_LIST.md     功能清单（功能一改必更）
├── UI_UX.md            UI/UX 规格
├── DATA_MODEL.md       数据库表 + 字段（与代码 0 误差对齐）
├── API_SPEC.md         接口 + 服务清单（与代码 0 误差对齐）
├── ROADMAP.md          史诗→特性→卡片路线图
├── TRACEABILITY.md     需求↔卡片↔测试↔证据
├── NAVIGATION.md       定位地图（出问题/找代码看这里）
├── cards/              模块卡片存档
├── DEVLOG.md           开发日志（每次追加）
├── LESSONS.md          踩坑积累
├── CHANGELOG.md        交付记录
└── verify.sh           构建 && 测试（pre-commit 门禁依据）
```

- **计划模式先行**：动手前先聊清楚、确认总架构 + 功能清单 + UI/UX + 数据模型 + 接口，人拍板后才写代码。
- **分块处理**：大任务先拆成有序卡片清单，交人确认，一次只做一张、跑绿再下一张（隔离爆炸半径 + 改一块做全局影响分析）。
- **0 误差对齐**：功能清单/数据库/接口/UI 与代码严格一致，任何不符即缺陷。
- **资深团队入戏**：加载即扮演 PM/架构/数据模型/大数据/后端/前端 六顶资深帽子，各带把关清单（`roles.md`）。
- **可交接**：`HANDOFF.md` 边开发边写、命令亲测有效 + 充分注释 + 开发日志，让没参与过的开发人员照文档直接上手。
- **可定位**：`NAVIGATION.md` 定位地图 + 代码锚点，凭功能名/报错/表名/字段 30 秒定位到代码、表、接口——出问题知道去哪改。

## 设计原则

- **人做决策，模型执行**：架构与模块边界由人拍板，模型只在卡片范围内干活。
- **不臆测 / 真实跑 / 如实报**：结论必须紧跟真实命令输出与退出码。
- **语言平等**：主流程零语言偏向；`review.md` 为 Java/Go/Python/前端等提供地位平等的附录，可自行追加。
