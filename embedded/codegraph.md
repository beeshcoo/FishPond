# FishPond · CodeGraph（系统知识图谱）

> **内嵌子技能**。把整个项目变成一张**可秒级定位**的知识图谱：模块、服务、接口、表、字段、中间件、页面、用户故事之间的调用/读写/依赖关系。
> 开发按图谱分块进行；**任何变更同步更新图谱**，解决"不用遍整个项目去找、地图一目了然"。
> **语言无关**：图谱是逻辑模型，与 Java/Go/Python/前端无关。

## 两张地图（缺一不可）
| 地图 | 文件 | 回答什么 |
|---|---|---|
| **故事地图** | `.fishpond/STORY_MAP.md` | 用户故事→主/支撑/分支/异常流程→触达哪些功能/页面/接口 |
| **系统图谱** | `.fishpond/SYSTEM_GRAPH.md` | 模块/服务/API/DB表/字段/中间件/页面的节点与边（调用/读写/依赖） |

两者**互相链接**：故事地图里的每个故事 ID 指向系统图谱节点；图谱节点指回 NAVIGATION 代码位置。

## 节点类型（统一 ID 前缀）
```
ST-xxx  用户故事      MOD-xxx 模块/子域    SVC-xxx 服务/应用
API-xxx 接口端点      TBL-xxx 数据表       FLD-xxx 关键字段
MW-xxx  中间件        PG-xxx  前端页面     CMP-xxx 关键组件
ERR-xxx 错误码        F-xxx   功能(对齐 FEATURE_LIST)
```

## 边类型
```
calls      A 调用 B（同步/异步标注）
reads      A 读 B（表/缓存/消息）
writes     A 写 B
depends_on A 依赖 B 才能运行
implements ST-xxx 实现某用户故事
displays   页面展示某 API/数据
```

## 维护协议（边开发边更新，不许攒到最后）
```
1. 计划模式：产出 STORY_MAP 骨架 + SYSTEM_GRAPH 子域/模块骨架。
2. 每张模块卡片完成后：补/更新对应节点与边；与 DATA_MODEL/API_SPEC/NAVIGATION 0 误差对齐。
3. 任何接口/表/页面/中间件变更：同一 commit 内更新 SYSTEM_GRAPH + STORY_MAP（若流程变）。
4. 交付前：随机抽 3 个节点，30 秒内能从图谱跳到代码/表/接口。
```

## 图谱格式（Mermaid + 索引表）
`SYSTEM_GRAPH.md` 结构：
1. **子域总览图**（mermaid graph）
2. **主流程序列图**（mermaid sequenceDiagram，主/分支/异常各一条）
3. **节点索引表**（ID | 类型 | 名称 | 路径/位置 | 关联故事）
4. **边索引表**（from | to | 关系 | 说明）

## 秒级定位配方
```
问"改登录影响谁"     → SYSTEM_GRAPH 搜 API-login / MOD-auth → 看 calls/depends_on 出边
问"这表谁在用"       → 搜 TBL-xxx → 所有 reads/writes 边
问"这故事涉及什么"   → STORY_MAP 找故事 → 链接的 API/TBL/PG 节点
问"代码在哪"         → 节点 → NAVIGATION 代码位置列
```

## 与 NAVIGATION 的关系
- NAVIGATION = **扁平逆向索引**（功能/错误码/字段 → 代码），适合排障。
- CodeGraph = **关系网络**（谁调谁、谁读写谁），适合影响分析与架构演进。
- 两者必须一致；NAVIGATION 可从 SYSTEM_GRAPH 自动生成索引部分。
