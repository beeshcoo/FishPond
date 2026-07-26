# 流程架构 (Flow Architecture)

> `.fishpond/FLOW_ARCHITECTURE.md` — 主/支撑/分支/异常四类流；mermaid 源可导入 Visio/draw.io。
> 与 STORY_MAP 故事 ID 互链。

---

## <业务能力名> · 主流程
**关联故事**：ST-001, ST-002

```mermaid
flowchart TD
  A[用户打开页面] --> B{已登录?}
  B -->|否| C[跳转登录]
  B -->|是| D[加载数据]
  D --> E[展示列表]
```

## <业务能力名> · 支撑流（鉴权/通知/审计）
```mermaid
flowchart LR
  R[请求] --> AUTH[鉴权中间件]
  AUTH --> AUDIT[写审计日志]
  AUDIT --> H[Handler]
```

## <业务能力名> · 分支流
```mermaid
flowchart TD
  X[提交] --> Y{金额>阈值?}
  Y -->|是| Z[并行审批]
  Y -->|否| W[单级审批]
```

## <业务能力名> · 异常流
```mermaid
flowchart TD
  E1[API 错误] --> E2{错误码}
  E2 -->|4xx| E3[展示用户可读文案]
  E2 -->|5xx| E4[重试+联系支持]
  E2 -->|超时| E5[保存草稿]
```

## 流程 ↔ 技术映射
| 流程节点 | API | 表 | 页面 |
|---|---|---|---|
| 加载数据 | GET /api/v1/xxx | tbl_xxx | PG-list |
