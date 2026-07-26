# RingPond 圈域 · 完整索引

> 品牌 **RingPond（圈域）** · 当前 **v2.1.0** · About → [ABOUT.md](ABOUT.md) · 教程 → [TUTORIAL.md](TUTORIAL.md)

## 人先看（Human）
| 文件 | 给谁看 | 内容 |
|---|---|---|
| [ABOUT.md](ABOUT.md) | 所有人 | 品牌 About：使命、三位一体、十一项能力 |
| [TUTORIAL.md](TUTORIAL.md) | 所有人 | **非常详细的完整教程（11篇）** |
| [QUICKSTART.md](QUICKSTART.md) | 所有人 | 5 分钟安装+触发+把关 |
| [USAGE.md](USAGE.md) | 所有人 | 使用教程+实战演练 |
| [README.md](README.md) | 所有人 | 项目介绍、安装 |
| [CHANGELOG.md](CHANGELOG.md) | 维护者 | 版本变更 |

## 机器加载（Agent 入口）
| 文件 | 何时读 |
|---|---|
| [SKILL.md](SKILL.md) | **始终首先加载**（YAML frontmatter + 路由） |
| [roles.md](roles.md) | 需要以资深团队身份把关时 |
| [dev.md](dev.md) | 开发/改造单个模块 |
| [large-project.md](large-project.md) | 从零做大型项目 |
| [brownfield.md](brownfield.md) | 接手旧项目/拆细块/棕地改造 |
| [review.md](review.md) | 代码审查 |
| [debug.md](debug.md) | 生产排查 |
| [examples.md](examples.md) | 需要看填好的范例 |

## 项目文档模板（拷进 `<项目>/.fishpond/`）
| 模板 | 用途 | 变更铁律 |
|---|---|---|
| [PROJECT_PROFILE.md](templates/PROJECT_PROFILE.md) | 技术栈+构建/测试命令 | 命令须真跑验证 |
| [ARCHITECTURE.md](templates/ARCHITECTURE.md) | 总架构 | 架构一变必更 |
| [FEATURE_LIST.md](templates/FEATURE_LIST.md) | 功能清单 | 功能一改必更 |
| [UI_UX.md](templates/UI_UX.md) | UI/UX 规格 | UI 一变必更 |
| [DATA_MODEL.md](templates/DATA_MODEL.md) | 表+字段 | 与迁移/实体 0 误差 |
| [API_SPEC.md](templates/API_SPEC.md) | 接口+服务 | 与代码 0 误差 |
| [ROADMAP.md](templates/ROADMAP.md) | 史诗→卡片路线图 | 变更需人确认 |
| [TRACEABILITY.md](templates/TRACEABILITY.md) | 需求追溯矩阵 | 交付前逐行核对 |
| [NAVIGATION.md](templates/NAVIGATION.md) | 定位地图 | 新功能/接口/表必补 |
| [CARD.md](templates/CARD.md) | 模块卡片标准模板 | 一模块一张 |
| [HANDOFF.md](templates/HANDOFF.md) | 交接清单 | 边开发边写 |
| [DEVLOG.md](templates/DEVLOG.md) | 开发日志 | 每次收工追加 |
| [LESSONS.md](templates/LESSONS.md) | 踩坑积累 | 踩坑即追加 |
| [CHANGELOG.project.md](templates/CHANGELOG.project.md) | 项目交付记录 | 每次交付追加 |

## 门禁与安装（Enforcement + Install）
| 文件 | 用途 |
|---|---|
| [install.ps1](install.ps1) / [install.sh](install.sh) | 安装技能到 Claude Code / Cursor |
| [init-project.ps1](init-project.ps1) / [init-project.sh](init-project.sh) | 给目标项目初始化 `.fishpond/` + 门禁 |
| [enforcement/pre-commit](enforcement/pre-commit) | git 提交门禁 |
| [enforcement/verify.example.ps1](enforcement/verify.example.ps1) | Windows 验证脚本模板 |
| [enforcement/verify.example.sh](enforcement/verify.example.sh) | POSIX 验证脚本模板 |
| [enforcement/ci.example.yml](enforcement/ci.example.yml) | GitHub Actions CI 模板 |
| [enforcement/settings.example.json](enforcement/settings.example.json) | Claude Code 权限护栏 |

## 场景 → 读哪些文件
```
新项目从零        → SKILL → large-project → dev → templates/*
加/改一个模块     → SKILL → dev → templates/CARD.md
接手旧项目        → SKILL → brownfield → USAGE §6.5 → dev
审查代码          → review
线上故障          → debug → NAVIGATION
交付/交接         → HANDOFF + NAVIGATION + FEATURE_LIST + DATA_MODEL + API_SPEC
DeepSeek 易错     → SKILL「为什么对 DeepSeek 关键」+ QUICKSTART §4
```

## 仓库
https://github.com/beeshcoo/FishPond
