# 踩坑积累 (Lessons Learned)

> 放在 `<项目>/.fishpond/LESSONS.md`。每次踩坑/被审查驳回/生产故障后追加一条。
> **下次开工先读本文件**，避免同一坑踩两次。

## 条目格式（复制往上加，最新在最上）
```
### YYYY-MM-DD · <模块/功能/场景>
- 现象：<看到了什么>
- 根因：<为什么发生（5 Whys 可简写）>
- 修复：<怎么修的，commit/PR>
- 以后怎么避免：<规范/检查项/门禁补充>
- 关联：cards/xxx.md | NAVIGATION 错误码 XXX | DL-xxx
```

---

### 示例 · pre-commit 在 Windows 上 verify 找不到 PowerShell
- 现象：commit 时提示找不到 verify，或跳过了测试门禁。
- 根因：只放了 verify.ps1 但 Git Bash 环境没有 pwsh。
- 修复：安装 PowerShell 7，或同时提供 verify.sh 作为回退。
- 以后怎么避免：PROJECT_PROFILE 里写明 verify 用 ps1 还是 sh；install 时两种都生成。
