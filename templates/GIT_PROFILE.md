# Git 协作画像

> `.fishpond/GIT_PROFILE.md` — 安装/初始化 FishPond 时记录（**不含 token/密码**）。
> 用于版本追溯、回滚、解决记忆缺失（每次 push 对应 DEVLOG/CHANGELOG 条目）。

## 仓库信息（setup-git 脚本写入或手填）
```yaml
远程仓库: "<https://github.com/org/repo.git>"
默认分支: "main"
Git 用户: "<name>"
Git 邮箱: "<email>"
```

## 版本策略
```
- 一模块一分支：feature/<模块名>
- 一卡一 commit：消息格式 feat(module): 简述 [F-xxx]
- 禁止：push --force / reset --hard（FishPond 铁律）
- 回滚：git revert <hash>，并在 DEVLOG 记录
```

## Push 记录（每次 push 追加一行）
| 日期 | 分支 | commit | 说明 | 关联卡片/DEVLOG |
|---|---|---|---|---|
| | | | | |

## 回滚手册
```
1. git log --oneline -20          # 找目标 hash
2. git revert <hash>              # 安全回滚（不 rewrite 历史）
3. 更新 LESSONS + DEVLOG + 通知团队
```

⚠ **永不**在本文件写入 PAT/token/密码。
