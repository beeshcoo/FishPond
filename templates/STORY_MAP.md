# 故事地图 (Story Map)

> `.fishpond/STORY_MAP.md` — 用户故事 → 流程 → 功能 → 页面 → 接口 → 表 的**业务大地图**。
> 与 `SYSTEM_GRAPH.md` 双向链接；流程细节见 `FLOW_ARCHITECTURE.md`。

## 史诗清单
| Epic | 说明 | 优先级 | 状态 |
|---|---|---|---|
| EP-01 | 身份与组织 | P0 | |

---

## 故事详情

### ST-001 · <角色> 想要 <能力> 以便 <价值>
- **Epic**：EP-01
- **功能 ID**：F-001
- **流程**：[FLOW_ARCHITECTURE §登录主流程](FLOW_ARCHITECTURE.md#登录主流程)
- **页面**：PG-login
- **接口**：API-POST-auth-login
- **数据**：TBL-app_user
- **图谱节点**：[SYSTEM_GRAPH MOD-auth](SYSTEM_GRAPH.md)
- **验收标准**：
  - [ ] 正确凭证可登录
  - [ ] 错误凭证返回 AUTH_INVALID_CREDENTIALS
- **卡片**：cards/user-auth.md
- **状态**：待开发 | 开发中 | 已完成

<!-- 复制上方块追加更多 ST-xxx -->

## 故事 → 技术映射总表
| ST-ID | F-ID | PG | API | TBL | 卡片 |
|---|---|---|---|---|---|
| ST-001 | F-001 | PG-login | API-POST-auth-login | TBL-app_user | cards/user-auth.md |

## 维护规则
- 新故事先登记 ST-ID，再开发
- 故事变更同步 FEATURE_LIST + SYSTEM_GRAPH + NAVIGATION
