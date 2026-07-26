# FishPond · Darwin（技能进化 / 训练式打分）

> **内嵌子技能**。把"优化 skill"当成**训练模型**：每次开发会话/每张卡片/每次交付后**打分→复盘→更新规则**，让整个 FishPond（含 Taste/CodeGraph/工程规范）**越来越强**。
> 分数与进化记录落盘 `.fishpond/DARWIN_SCORES.md` + `.fishpond/EVOLUTION.md`，跨会话不丢。

## 训练循环（每次收工必做）
```
开发/交付 → 按 Rubric 打分 → 低分项写进 EVOLUTION(改什么规则) → 更新 LESSONS/TASTE/ENGINEERING_CHARTER → 下次会话先读 EVOLUTION
```

## 打分 Rubric（每项 0–2 分，满分 20，真实自评+证据）
| # | 维度 | 0 分 | 1 分 | 2 分 |
|---|---|---|---|---|
| 1 | 需求/方案对齐 | 偏离卡片/故事地图 | 基本对齐有小偏差 | 与 STORY_MAP/卡片完全一致 |
| 2 | 测试与门禁 | 未跑/谎报 | 跑了但有红或跳过 | 真跑全绿+pre-commit/CI 过 |
| 3 | 文档 0 误差 | 多处文档与代码不符 | 部分同步 | FEATURE/DATA/API/GRAPH 全一致 |
| 4 | 图谱同步 | 未更新 SYSTEM_GRAPH | 更了但不全 | 节点边与代码完全对齐 |
| 5 | Taste/UI | 7态缺/风格乱 | 基本可用有小问题 | 过 Taste 清单+用户可接受 |
| 6 | 可定位性 | 找不到改哪 | NAVIGATION 部分可用 | 30秒定位任意节点 |
| 7 | 交接就绪 | HANDOFF 空/糊弄 | 部分可跑 | 新人照 HANDOFF 可上手 |
| 8 | 全局影响 | 改崩他处未发现 | 发现但未及时修 | 影响分析+全量回归绿 |
| 9 | 工程规范 | 违反铁律 | 有小问题已记 | 无违反+LESSONS 已追加 |
| 10 | 记忆持久 | 未写 DEVLOG/SESSION | 写了但不全 | SESSION+DEVLOG+EVOLUTION 齐全 |

**判定**：
- ≥16：优秀，沉淀"做对了什么"到 EVOLUTION 最佳实践。
- 12–15：合格，低分项必须写改进动作。
- <12：不合格，**不许开下一张卡**，先补洞再打分。

## EVOLUTION.md 写什么
```
### YYYY-MM-DD · 会话/卡片 xxx · 得分 NN/20
- 低分维度：#3 文档 #4 图谱
- 根因：<为什么>
- 技能补丁：<新增/修改哪条规则，写进 ENGINEERING_CHARTER 或 TASTE_PROFILE 或 review 清单>
- 下次强制：<开工先读 xxx；交付必查 xxx>
```

## 进化对象（什么会变强）
| 对象 | 进化方式 |
|---|---|
| Taste 审美 | TASTE_PROFILE 规则区追加 |
| CodeGraph 习惯 | SYSTEM_GRAPH 模板/必填节点类型追加 |
| 工程规范 | docs/ENGINEERING_CHARTER.md 追加条目 |
| 审查清单 | review.md 项目级附录 `.fishpond/review.local.md` |
| 踩坑免疫 | LESSONS.md |

## 与 SESSION_STATE 联动（记忆缺失）
每次收工更新 `.fishpond/SESSION_STATE.md`：当前卡、进度、下一步、未决问题、最近 Darwin 分。下次开工**先读 SESSION_STATE**。

## 禁止
```
❌ 不打分就宣称交付完成   ❌ 低分不写 EVOLUTION 补丁
❌ 只抱怨不沉淀规则       ❌ 分数造假（无测试输出却给 2 分）
```
