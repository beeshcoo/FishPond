# 开发交接文档（总册）

> `docs/HANDOFF/README.md` — 需求 #6：系统上线后交给开发人员的**完整交接入口**。
> 细则仍在 `.fishpond/HANDOFF.md`（环境命令级）；本目录是**结构化总册**。

## 阅读顺序（新人第一天）
1. [../SOLUTION.md](../SOLUTION.md) — 系统是做什么的
2. `.fishpond/HANDOFF.md` — 怎么跑起来（逐步命令）
3. `.fishpond/SYSTEM_GRAPH.md` — 系统关系地图（秒级定位）
4. `.fishpond/NAVIGATION.md` — 功能/错误/表→代码
5. `.fishpond/STORY_MAP.md` — 业务故事与流程
6. [../SOP.md](../SOP.md) — 上线与回滚
7. [../ONBOARDING.md](../ONBOARDING.md) — 产品内新手引导规格
8. [../ENGINEERING_CHARTER.md](../ENGINEERING_CHARTER.md) — 工程规范

## 文档 ↔ 代码对齐承诺
所有 `.fishpond/` 与 `docs/` 文档与代码 **0 误差**；不符即缺陷。

## 出问题先看哪
| 现象 | 文档 |
|---|---|
| 起不来 | HANDOFF §环境搭建 |
| 不知道改哪 | NAVIGATION / SYSTEM_GRAPH |
| 业务不懂 | STORY_MAP / SOLUTION |
| 线上故障 | SOP + debug.md 流程 |
| UI 不对 | UI_UX + TASTE_PROFILE |

## 维护
- 每张模块卡片交付时更新相关章节
- 发版时更新 SOP 与 HANDOFF 版本号
