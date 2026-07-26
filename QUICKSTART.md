# FishPond · 5 分钟快速上手

> 详细教程见 [USAGE.md](USAGE.md)。本文只讲最短路径。

## 1. 安装（1 分钟）
```powershell
git clone https://github.com/beeshcoo/FishPond.git
cd FishPond
./install.ps1                    # Claude Code（默认）
./install.ps1 -Target both       # 同时装 Cursor
```
重启 VS Code / Claude Code。

## 2. 给项目初始化（1 分钟）
```powershell
cd C:\path\to\你的项目
C:\path\to\FishPond\init-project.ps1    # 生成 .fishpond/ + 装 pre-commit 门禁
```
然后编辑 `.fishpond/verify.ps1`，填入真实的**构建 + 测试**命令。

## 3. 对 AI 说什么（按场景选一句）

| 场景 | 复制这句 |
|---|---|
| **新项目** | `用 FishPond 做一个 XX 系统，先进入计划模式聊需求，确认架构和功能清单后再写代码` |
| **加模块** | `用 FishPond 开发 XX 模块，先写模块卡片给我确认` |
| **旧项目** | `用 FishPond 接手这个已有项目，先只圈鱼塘测绘、不改代码` |
| **旧项目拆块** | `我这轮只改 XX 这块，用 FishPond 拆成非常细的模块卡片清单，先给清单别写代码` |
| **审查** | `用 FishPond 审查 XX 模块` |
| **线上故障** | `线上 XX 出问题，用 FishPond 帮我排查` |

## 4. 你要把关的三件事
1. **计划模式拍板**：架构/功能清单/数据模型/接口，你确认后才允许写码。
2. **看测试输出**：它说"通过"就追问"贴出刚运行的命令和原始输出"。
3. **一张卡一张卡**：一张没跑绿，不许开下一张。

## 5. 项目里会多出什么
```
你的项目/.fishpond/
  ARCHITECTURE.md    总架构（架构一变必更）
  FEATURE_LIST.md    功能清单（功能一改必更）
  DATA_MODEL.md      表+字段（与代码一致）
  API_SPEC.md        接口（与代码一致）
  NAVIGATION.md      定位地图（出问题去哪改）
  HANDOFF.md         交接清单（边开发边写）
  DEVLOG.md          开发日志
  cards/             模块卡片
  verify.ps1         门禁用的构建+测试命令
```

## 6. 门禁怎么拦你
`git commit` → 自动跑 verify → **测试不绿提交不了** → PR 上 CI 再拦一道。

紧急绕过（清楚后果）：`FISHPOND_SKIP=1 git commit ...`

---

**下一步**：读 [USAGE.md](USAGE.md) 看完整演练；读 [brownfield.md](brownfield.md) 看旧项目拆块专册。
