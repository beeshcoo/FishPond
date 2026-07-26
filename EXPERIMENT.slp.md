# FishPond 实验指南 · software-lifecycle-platform

> 用本仓库做 FishPond v2 首批实验项目（棕地：已有大量代码与 `.fishpond/` 基础）。

## 1. 确保技能 v2 已安装
```powershell
cd C:\Users\Administrator\fishpond-pub   # 或 clone FishPond 仓库
./install.ps1
```
重启 Claude Code。

## 2. 补全 v2 骨架（不覆盖已有文件）
```powershell
cd C:\Users\Administrator\software-lifecycle-platform
C:\Users\Administrator\.claude\skills\fishpond\init-project.ps1 -Project .
```
会新增：`STORY_MAP.md`、`SYSTEM_GRAPH.md`、`FLOW_ARCHITECTURE.md`、`TASTE_PROFILE.md`、`DARWIN_SCORES.md`、`EVOLUTION.md`、`SESSION_STATE.md`、`GIT_PROFILE.md`，以及 `docs/SOLUTION.md` 等（已存在则跳过）。

## 3. 对 AI 说的实验话术（按顺序）

### 阶段 A · 测绘（不改代码）
```
用 FishPond 接手 software-lifecycle-platform。先只圈鱼塘：
通读现有代码，增量完善 ARCHITECTURE / FEATURE_LIST / DATA_MODEL / API_SPEC / NAVIGATION，
并新建 STORY_MAP + SYSTEM_GRAPH 骨架。禁止改业务代码。
```

### 阶段 B · 拆组织中心+审批中心为细卡
```
我这轮只改组织中心与审批中心。用 FishPond 拆成非常细的模块卡片写入 ROADMAP，
标注现有代码位置与 NAVIGATION 引用。先给清单，别写代码。
```

### 阶段 C · 一张卡一张卡 + 三位一体
```
做第一张卡。要求：Taste 审查 UI；更新 SYSTEM_GRAPH；交付后 Darwin 打分；
更新 SESSION_STATE 和 docs/HANDOFF。
```

## 4. verify.ps1 建议填法（本项目）
编辑 `.fishpond/verify.ps1` 填入真实命令，例如：
- 后端：`services\server` 下 `mvnw.cmd test`
- 前端：`apps\web` 下测试命令
（以 PROJECT_PROFILE 真跑验证为准。）

## 5. 实验成功标准
- [ ] SYSTEM_GRAPH 能 30 秒定位任意模块/接口/表
- [ ] STORY_MAP 覆盖 REQ-0014 等核心需求
- [ ] docs/HANDOFF 新人可跑通
- [ ] Darwin 至少 3 次打分记录，EVOLUTION 有补丁
- [ ] TASTE_PROFILE 有至少 2 条项目专属 UI 规则
