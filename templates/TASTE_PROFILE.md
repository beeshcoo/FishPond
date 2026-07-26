# Taste 设计 DNA (Taste Profile)

> `.fishpond/TASTE_PROFILE.md` — 进化型设计师的**深造笔记**；规则只增不删（废弃标 `[废弃]`）。
> 详见 [embedded/taste.md](../embedded/taste.md)。

## 项目视觉基调
```
风格：<专业/简洁/…>   主色：<token>   字体：<…>   圆角：<…>   设计系统：<@xxx/ui | 自研>
```

## 强制规则（进化累积区）
1. 间距只用 token：`--space-*`，禁止魔法数字
2. 状态 Badge 用 `.slp-status-badge`，禁止硬编码色块
3. 列表页必须：搜索+筛选+空态+错误态+分页
4. <!-- 每次 UI 问题后在此追加新规则 -->

## 组件模式库（做得好可复用）
| 模式名 | 适用场景 | 参考页面/组件 |
|---|---|---|
| 主从详情 | 列表+右侧详情 | ApprovalCenter inbox |

## 审美进化日志
### YYYY-MM-DD · <页面>
- 做得好：…
- 问题：…
- 新规则：…（已写入上方规则区 #N）
- Darwin 分：…
