# 接口与服务清单 (API & Services)

> 放在 `<项目>/.fishpond/API_SPEC.md`。**接口真相源**：路径/方法/入参/出参/错误码/鉴权与实际代码**一致**。
> 若项目用 OpenAPI/Proto，这里可只放索引 + 链接，但清单与生成物必须同步。

## 服务清单（后端服务/模块对外能力）
| 服务/模块 | 职责 | 对外接口前缀 | 依赖服务 |
|---|---|---|---|
| user-auth | 认证鉴权 | /api/v1/auth | - |
| order | 订单 | /api/v1/orders | user-auth, coupon |

---

## 接口清单
### POST /api/v1/auth/login —— 登录
- 鉴权：公开
- 入参(body)：`{ username: string(必填), password: string(必填) }`
- 出参(200)：`{ token: string, userId: uuid }`
- 错误：`401 AUTH_INVALID_CREDENTIALS`
- 关联功能：F-001 | 关联表：app_user | **代码：src/user/AuthController::login**

### POST /api/v1/orders —— 创建订单
- 鉴权：需认证
- 入参(body)：`{ items: [{skuId, qty}](必填), couponId?: uuid }`
- 出参(201)：`{ id: uuid, amount: number, status: string }`
- 错误：`400 ORDER_ITEMS_EMPTY` / `409 COUPON_EXPIRED`
- 关联功能：F-002 | 关联表：orders, order_item | **代码：src/order/OrderController::create**

## 交付前一致性自检
```
☐ 每个接口都在代码里存在，路径/方法/入参/出参/错误码一字不差？
☐ 每个接口都标了鉴权（公开的显式标注公开）？
☐ 每个接口的"关联功能/关联表"与 FEATURE_LIST / DATA_MODEL 对得上？
☐ 对外接口向后兼容（未删字段/未改签名）？破坏性变更是否加了版本？
☐ 无"代码有接口、清单无"（影子接口）或反之？
```
