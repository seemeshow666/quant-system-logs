# Quant System Logs

量化交易系统环境日志与恢复工具

## 📁 目录结构

```
system-logs/
├── logs/                    # 操作日志
│   ├── software/           # 软件安装记录
│   │   ├── conda.md        # Conda 环境配置
│   │   ├── docker.md       # Docker 配置
│   │   ├── mysql.md        # MySQL 配置
│   │   └── rdagent.md      # RD-Agent 安装记录
│   ├── config/             # 配置文件备份
│   └── backup.log          # 备份日志
├── scripts/                # 工具脚本
│   ├── backup.sh           # 备份脚本（每日自动执行）
│   ├── restore.sh          # 一键恢复脚本
│   └── health_check.sh     # 健康检查脚本
├── .env.example            # 配置模板
└── README.md               # 本文件
```

## 🚀 快速开始

### 1. 配置 LLM API keys

```bash
cp .env.example .env
# 编辑 .env 文件，填入你的 API keys
nano .env
```

需要配置：
- **DeepSeek API Key**: https://platform.deepseek.com
- **SiliconFlow API Key**: https://www.siliconflow.cn

### 2. 检查系统状态

```bash
./scripts/health_check.sh
```

### 3. 启动 RD-Agent

```bash
# 激活 Conda 环境
conda activate rdagent

# 启动综合量化场景
rdagent fin_quant
```

## 📦 备份与恢复

### 手动备份

```bash
./scripts/backup.sh
```

备份文件保存在 `~/system-logs/backups/`

### 一键恢复

在新电脑上：

```bash
# 1. 克隆仓库
git clone <your-repo-url> ~/system-logs
cd ~/system-logs

# 2. 解密敏感文件
git-crypt unlock

# 3. 执行恢复
./scripts/restore.sh
```

## ⏰ 自动备份

系统每天凌晨 2:00 自动执行备份：

```bash
# 查看定时任务
crontab -l

# 查看备份日志
cat logs/cron.log
```

## 🔧 主要组件

| 组件 | 版本 | 说明 |
|------|------|------|
| Conda | 25.11.1 | Python 环境管理 |
| RD-Agent | 0.8.0 | 量化交易 AI 代理 |
| Qlib | 0.0.2.dev20 | 微软量化投资平台 |
| MySQL | 8.0 | 数据存储 |
| Docker | 28.2.2 | 容器化 |

## 📊 目录说明

| 目录 | 用途 |
|------|------|
| `~/data/qlib/` | Qlib 缓存数据 |
| `~/data/csv/` | CSV 数据文件 |
| `~/data/database/` | MySQL 数据目录 |
| `~/quant/projects/` | RD-Agent 项目文件 |

## 🔐 Git 加密

敏感配置文件使用 `git-crypt` 加密：

```bash
# 查看加密状态
git-crypt status

# 解密（需要 GPG 密钥）
git-crypt unlock

# 加密新文件
git-crypt add GIT-CRYPT-KEY <filename>
```

## 📝 更新日志

- **2026-02-12**: 初始安装
  - Conda + RD-Agent 环境
  - MySQL 数据库配置
  - Docker 容器化支持
  - 备份/恢复脚本

## ⚠️ 注意事项

1. **API Keys**: 不要将真实的 API keys 提交到 Git（使用 `.env.example`）
2. **数据库密码**: 默认密码 `quant@2024`，建议修改
3. **备份目录**: `~/system-logs/backups/` 会越来越大，定期清理旧备份
4. **Qlib 数据**: 大型数据集不纳入 Git 备份

## 📚 相关文档

- [RD-Agent 官方文档](https://rdagent.readthedocs.io/)
- [Qlib GitHub](https://github.com/microsoft/qlib)
- [DeepSeek API](https://platform.deepseek.com)
- [SiliconFlow](https://www.siliconflow.cn)
