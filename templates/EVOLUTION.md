# 技能进化补丁 (Evolution)

> `.fishpond/EVOLUTION.md` — Darwin 低分/踩坑后**具体改哪条规则**，让 FishPond+Taste+CodeGraph **越来越强**。

## 补丁记录（最新在上）
### YYYY-MM-DD · 得分 NN/20 · cards/xxx
- **低分维度**：#4 图谱 #5 Taste
- **根因**：开发完未更新 SYSTEM_GRAPH；列表页缺空态
- **技能补丁**：
  - ENGINEERING_CHARTER 新增：「每张卡 commit 前必须 diff SYSTEM_GRAPH」
  - TASTE_PROFILE 新增规则 #N：「列表 7 态缺一项不许合并」
- **下次强制**：Phase 5 增加图谱 diff 自检；review 加第 22 项

## 已生效的全局规则索引
| 规则 | 来源日期 | 写入位置 |
|---|---|---|
| 示例：图谱与代码同 commit | 2026-xx-xx | ENGINEERING_CHARTER §… |
