# 项目画像 (Project Profile)

> Phase 0 扫描后生成/更新。dev.md、review.md、debug.md 里所有 `<占位符>` 从这里取值。
> 扫不准的字段不要编 —— 标"待确认"并问人。**构建/测试命令必须先真跑一次验证有效再写入。**

## 基本信息
```yaml
项目名称: "<PROJECT_NAME>"
项目描述: "<一句话>"
仓库地址: "<git remote url>"
```

## 技术栈（语言无关，填实际用到的）
```yaml
后端语言: "<Java | Go | Python | Rust | Node.js | C# | PHP | Ruby | ...>"   后端版本: "<...>"
后端框架: "<...>"
前端语言: "<TypeScript | JavaScript | 无>"   前端框架: "<React | Vue | Angular | ... | 无>"   前端构建: "<Vite | Webpack | ...>"
数据库: "<PostgreSQL | MySQL | MongoDB | SQLite | ...>"   缓存: "<Redis | 无>"   消息队列: "<Kafka | RabbitMQ | 无>"
迁移工具: "<Flyway | Liquibase | golang-migrate | alembic | prisma | 无>"   对象存储: "<S3 | MinIO | 本地 | 无>"
容器化: "<Docker | 无>"   编排: "<Kubernetes | Docker Compose | systemd | 无>"
```

## 构建与测试（命令唯一真相源 —— 已真跑验证）
```yaml
后端构建命令: "<真跑过的命令>"
后端测试命令: "<真跑过的命令>"
后端启动命令: "<...>"
前端安装命令: "<...>"
前端构建命令: "<...>"
前端测试命令: "<...>"
CI 验证命令: "<...>"
覆盖率阈值: "<如 行覆盖 ≥ 70% / 关键模块 ≥ 85%；verify 脚本内做硬判定，未达标即失败>"
verify 聚合命令: "<写进 .fishpond/verify.sh 或 verify.ps1：构建 && 测试(含覆盖率阈值)>"
```

## 模块/包结构
```yaml
模块化方案: "<Spring Modulith | Go packages | npm workspaces | Python packages | 纯目录划分 | ...>"
包根路径: "<com.example | github.com/foo/bar | packages/ | ...>"
模块清单:
  - { 名: "<模块1>", 路径: "<路径>", 职责: "<职责>", API前缀: "<前缀>" }
```

## 命名约定
```yaml
类/类型: "<PascalCase>"  函数/方法: "<camelCase | snake_case>"  常量: "<UPPER_SNAKE_CASE>"  包/目录: "<lowercase | snake_case>"
表名: "<snake_case>"  列名: "<snake_case>"  索引: "idx_<表>_<列>"  外键: "fk_<表>_<列>"
API 风格: "<REST | gRPC | GraphQL>"  路径: "<名词复数>"  版本: "</api/v1 | Header | 无>"
```

## 部署环境
```yaml
开发: "<本地 | Docker Compose>"   测试: "<CI | 独立环境>"   预发布: "<...>"   生产: "<systemd | K8s | 云>"
部署方式: "<...>"   端口: "<...>"   健康检查: "<GET /health | ...>"
```
