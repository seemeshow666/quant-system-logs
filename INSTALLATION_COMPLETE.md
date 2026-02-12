# 📊 系统安装完成报告

## 安装日期
2026-02-12

## ✅ 已安装组件

| 组件 | 版本 | 状态 | 位置 |
|------|------|------|------|
| **Miniconda** | 25.11.1 | ✅ 已安装 | `/opt/miniconda3` |
| **Python** | 3.10 | ✅ rdagent 环境 | `~/.conda/envs/rdagent` |
| **RD-Agent** | 0.8.0 | ✅ 已安装 | `rdagent` 命令可用 |
| **Qlib** | 0.0.2.dev20 | ✅ 已安装 | pip 包 |
| **MySQL** | 8.0.45 | ✅ 运行中 | localhost:3306 |
| **Docker** | 28.2.2 | ✅ 已安装 | systemctl |
| **git-crypt** | 0.7.0 | ✅ 已配置 | ~/system-logs/ |

## 📁 目录结构

```
~/system-logs/              # 日志系统根目录 ✅
├── .git/                   # Git 仓库 ✅
├── .gitignore              # 忽略规则 ✅
├── .gitattributes          # git-crypt 配置 ✅
├── .env.example            # 配置模板 ✅
├── README.md               # 项目说明 ✅
├── logs/                   # 操作日志 ✅
│   └── software/           # 软件安装记录 ✅
│       ├── conda.md
│       ├── docker.md
│       ├── mysql.md
│       └── rdagent.md
└── scripts/                # 工具脚本 ✅
    ├── backup.sh           # 每日备份 (2:00 AM)
    ├── restore.sh          # 一键恢复
    └── health_check.sh     # 健康检查

~/data/                     # 数据目录 ✅
├── qlib/                   # Qlib 数据
│   ├── bin/
│   ├── source/
│   └── cache/
├── csv/                    # CSV 数据
└── database/               # MySQL 数据

~/quant/                    # RD-Agent 项目目录 ✅
└── projects/               # 量化策略项目
```

## 🔧 重要命令

### Conda 环境
```bash
# 激活环境
conda activate rdagent

# 查看环境
conda info --envs

# 检查包
conda list
```

### RD-Agent
```bash
# 综合量化（因子 + 模型）
rdagent fin_quant

# 因子挖掘
rdagent fin_factor

# 模型优化
rdagent fin_model

# 健康检查
rdagent health_check
```

### MySQL
```bash
# 连接数据库
mysql -u quant_user -p'quant@2024' quant_db

# 备份数据库
mysqldump -u root -p'quant@2024' quant_db > backup.sql
```

### 日志系统
```bash
# 手动备份
~/system-logs/scripts/backup.sh

# 一键恢复
~/system-logs/scripts/restore.sh

# 健康检查
~/system-logs/scripts/health_check.sh

# 查看日志
cat ~/system-logs/logs/software/conda.md
```

## ⚙️ 配置信息

### MySQL
- Host: localhost
- Port: 3306
- Database: quant_db
- User: quant_user
- Password: quant@2024

### LLM API（需要手动配置）
编辑文件：`~/system-logs/.env`

```bash
# DeepSeek Chat
CHAT_MODEL=deepseek/deepseek-chat
DEEPSEEK_API_KEY=your_key_here

# SiliconFlow Embedding
EMBEDDING_MODEL=litellm_proxy/BAAI/bge-m3
LITELLM_PROXY_API_KEY=your_key_here
LITELLM_PROXY_API_BASE=https://api.siliconflow.cn/v1
```

## 🔐 Git + git-crypt

```bash
# 查看状态
cd ~/system-logs
git-crypt status

# 解密（在新电脑上）
git-crypt unlock

# 提交更改
git add -A
git commit -m "描述"
git push
```

## ⏰ 自动备份

- **时间**: 每天凌晨 2:00
- **命令**: `~/system-logs/scripts/backup.sh`
- **日志**: `~/system-logs/logs/cron.log`
- **位置**: `~/system-logs/backups/`

## 🚀 下一步操作

### 1. 配置 LLM API Keys（必须）
```bash
cd ~/system-logs
cp .env.example .env
nano .env
# 填入 DeepSeek 和 SiliconFlow API keys
```

### 2. 重启终端或刷新配置
```bash
source ~/.bashrc
```

### 3. 启动 RD-Agent
```bash
conda activate rdagent
rdagent fin_quant
```

## 📝 待办事项

| 优先级 | 事项 | 状态 |
|--------|------|------|
| 🔴 高 | 配置 LLM API Keys | ⏳ 待用户操作 |
| 🔴 高 | 创建 GitHub 仓库并推送 | ⏳ 待用户操作 |
| 🟡 中 | 生成 GPG 密钥用于 git-crypt | ⏳ 可选 |
| 🟢 低 | 测试完整恢复流程 | ⏳ 可选 |

## 🎯 使用场景

### 场景1：日常研究
```bash
conda activate rdagent
cd ~/quant
rdagent fin_quant
```

### 场景2：换电脑后恢复
```bash
# 1. 克隆仓库
git clone <your-repo-url> ~/system-logs
cd ~/system-logs

# 2. 解密
git-crypt unlock

# 3. 恢复
./scripts/restore.sh

# 4. 开始使用
conda activate rdagent
rdagent fin_quant
```

## 📞 技术支持

- RD-Agent 文档: https://rdagent.readthedocs.io/
- Qlib GitHub: https://github.com/microsoft/qlib
- DeepSeek API: https://platform.deepseek.com
- SiliconFlow: https://www.siliconflow.cn

---

**系统安装完成！🎉**
