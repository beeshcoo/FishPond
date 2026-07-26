# 工程规范 (Engineering Charter)

> `docs/ENGINEERING_CHARTER.md` — 需求 #11：开发过程中**不断追加**的规范，让愚蠢错误不再发生。
> Darwin EVOLUTION 低分项 → 沉淀为这里的新条目。

## 核心铁律（FishPond 内置，不可删）
```
1. 不臆测、要证据、真实跑、如实报
2. 架构/边界/契约由人拍板
3. 一次一张卡；改一块做全局影响分析+全量回归
4. 文档↔代码 0 误差；图谱/故事地图同步更新
5. 禁止 push --force / reset --hard
6. 密钥不入库；服务端鉴权，不单靠藏按钮
7. 迁移只增不改；破坏性改表 expand-contract
```

## 本项目追加规范（进化区）
| # | 日期 | 规则 | 来源(EVOLUTION/LESSONS) |
|---|---|---|---|
| P-001 | | 示例：列表页 7 态缺一不许合并 | EVOLUTION 2026-xx-xx |

## UI 规范
→ 同步 `.fishpond/TASTE_PROFILE.md` 强制规则区

## 审查与门禁
→ pre-commit + CI verify；PR 必须绿

## 变更流程
```
规范变更 → 更新本文件 → DEVLOG 记录 → 团队知晓
```
