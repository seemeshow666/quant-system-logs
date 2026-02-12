# Skill: rd-agent-usage

## 概述

RD-Agent 是微软开源的 AI 驱动研发代理系统，专注于数据驱动的量化交易研究。本 skill 提供 RD-Agent 的完整使用指南。

### 核心功能
- 🤖 **自动化研究**：自动提出想法、实现和验证
- 📊 **因子挖掘**：迭代式因子发现与优化
- 🧠 **模型训练**：自动化机器学习模型开发
- 📈 **综合量化**：因子 + 模型联合优化

### 适用场景
- 量化交易策略研究
- 金融因子挖掘
- 机器学习模型开发
- 数据科学研究

---

## 前置条件

### 已安装组件
| 组件 | 版本 | 检查命令 |
|------|------|----------|
| Conda | 25.11.1 | `conda --version` |
| Python | 3.10 | `python --version` |
| RD-Agent | 0.8.0 | `rdagent --help` |
| Qlib | 0.0.2.dev20 | `pip show qlib` |
| MySQL | 8.0 | `mysql --version` |
| Docker | 28.2.2 | `docker --version` |

### 环境变量
配置文件位置：`~/system-logs/.env`

必须配置的环境变量：
```bash
# LLM 配置
CHAT_MODEL=deepseek/deepseek-chat
DEEPSEEK_API_KEY=sk-xxxxx
EMBEDDING_MODEL=litellm_proxy/BAAI/bge-m3
LITELLM_PROXY_API_KEY=sk-xxxxx
LITELLM_PROXY_API_BASE=https://api.siliconflow.cn/v1

# 数据库配置
MYSQL_DATABASE=quant_db
MYSQL_USER=quant_user
MYSQL_PASSWORD=quant@2024
```

### 启动环境
```bash
# 激活 Conda 环境
conda activate rdagent

# 加载环境变量
cd ~/system-logs
source .env

# 进入项目目录
cd ~/quant
```

---

## 核心命令

### 1. 综合量化 (fin_quant)
```bash
rdagent fin_quant
```
**用途**：同时进行因子挖掘和模型优化的完整量化研究流程

**适用场景**：
- 端到端的量化策略开发
- 因子与模型联合优化
- 完整的回测评估

**输出**：
- 因子列表
- 训练好的模型
- 回测结果
- 策略收益报告

### 2. 因子挖掘 (fin_factor)
```bash
rdagent fin_factor
```
**用途**：专注于发现和优化金融因子

**适用场景**：
- Alpha 因子研究
- 技术因子开发
- 因子有效性验证

**可配置时间段**：
```bash
# 在 .env 中配置
QLIB_FACTOR_TRAIN_START=2008-01-01
QLIB_FACTOR_TRAIN_END=2014-12-31
QLIB_FACTOR_VALID_START=2015-01-01
QLIB_FACTOR_VALID_END=2016-12-31
QLIB_FACTOR_TEST_START=2017-01-01
QLIB_FACTOR_TEST_END=2020-12-31
```

### 3. 模型优化 (fin_model)
```bash
rdagent fin_model
```
**用途**：专注于机器学习模型的开发和优化

**适用场景**：
- 预测模型训练
- 模型结构调整
- 超参数优化

**可配置时间段**：
```bash
# 在 .env 中配置
QLIB_MODEL_TRAIN_START=2008-01-01
QLIB_MODEL_TRAIN_END=2014-12-31
QLIB_MODEL_VALID_START=2015-01-01
QLIB_MODEL_VALID_END=2016-12-31
QLIB_MODEL_TEST_START=2017-01-01
QLIB_MODEL_TEST_END=2020-12-31
```

### 4. 因子提取报告 (fin_factor_report)
```bash
rdagent fin_factor_report --report-folder=<path>
```
**用途**：从财务报告中自动提取因子

### 5. 通用模型 (general_model)
```bash
rdagent general_model <paper_url>
```
**用途**：从论文中自动实现模型

### 6. 数据科学 (data_science)
```bash
rdagent data_science --competition <competition_name>
```
**用途**：Kaggle 数据科学竞赛自动化

### 7. 健康检查
```bash
rdagent health_check
```
**用途**：检查系统配置和 API 连接状态

### 8. Web UI
```bash
rdagent ui --port 19899 --log-dir log/
```
**用途**：启动 Web 界面查看运行日志

---

## 常用工作流

### 工作流1：日常研究
```bash
# 1. 激活环境
conda activate rdagent

# 2. 加载配置
source ~/system-logs/.env

# 3. 进入项目目录
cd ~/quant

# 4. 运行研究
rdagent fin_quant
```

### 工作流2：因子研究
```bash
conda activate rdagent
source ~/system-logs/.env
cd ~/quant
rdagent fin_factor
```

### 工作流3：模型实验
```bash
conda activate rdagent
source ~/system-logs/.env
cd ~/quant
rdagent fin_model
```

### 工作流4：查看结果
```bash
# 启动 Web UI
rdagent ui --port 19899 --log-dir log/

# 或查看日志
cat log/*.log
```

---

## 执行环境配置

### Docker vs Conda

RD-Agent 可以在 Docker 或 Conda 环境中运行代码。

#### 对于量化场景 (Model/Quant)
```bash
# 使用 Docker（推荐，隔离执行）
MODEL_COSTEER_ENV_TYPE=docker

# 或使用本地 Conda
MODEL_COSTEER_ENV_TYPE=conda
```

#### 对于数据科学场景
```bash
# 使用 Docker（推荐）
DS_CODER_COSTEER_ENV_TYPE=docker

# 或使用本地 Conda
DS_CODER_COSTEER_ENV_TYPE=conda
```

**推荐**：使用 Docker 获得更好的隔离和可重复性

---

## 故障排除

### 问题1：API 认证失败
```bash
# 错误：API key 无效
# 解决：检查 .env 文件中的 API keys
cat ~/system-logs/.env
# 确认 DEEPSEEK_API_KEY 和 LITELLM_PROXY_API_KEY 正确
```

### 问题2：Docker 权限被拒
```bash
# 错误：PermissionError: [Errno 13] Permission denied
# 解决：将用户加入 docker 组
sudo usermod -aG docker $USER
# 然后重新登录或运行 newgrp docker
```

### 问题3：MySQL 连接失败
```bash
# 错误：无法连接数据库
# 解决：检查 MySQL 服务状态
sudo systemctl status mysql
# 或重启 MySQL
sudo systemctl restart mysql
```

### 问题4：端口被占用
```bash
# 错误：Port 19899 is occupied
# 解决：更换端口或停止占用进程
rdagent ui --port 19899 --log-dir log/ --no-check-env
# 或
rdagent ui --port 19900 --log-dir log/
```

### 问题5：磁盘空间不足
```bash
# 错误：No space left on device
# 清理 Qlib 缓存
rm -rf ~/data/qlib/cache/*
# 或
du -sh ~/data/qlib/
```

### 问题6：conda 环境问题
```bash
# 错误：rdagent: command not found
# 解决：重新激活环境
conda deactivate
conda activate rdagent
# 或重新安装
pip install rdagent --upgrade
```

### 健康检查
```bash
# 运行完整健康检查
rdagent health_check

# 只检查环境和 API
rdagent health_check --no-check-env --no-check-docker
```

---

## 目录结构

```
~/quant/                    # RD-Agent 项目目录
├── log/                    # 运行日志
│   └── __session__/        # 会话目录
└── projects/               # 项目文件

~/data/                     # 数据目录
├── qlib/                   # Qlib 缓存
│   ├── bin/
│   ├── source/
│   └── cache/
├── csv/                    # CSV 数据
└── database/               # MySQL 数据

~/system-logs/              # 日志系统
├── .env                    # API 配置
└── logs/software/          # 安装日志
```

---

## 最佳实践

### 1. 定期备份
```bash
# 手动备份
~/system-logs/scripts/backup.sh

# 或查看自动备份
cat ~/system-logs/logs/cron.log
```

### 2. 日志管理
```bash
# 查看最新日志
tail -f ~/quant/log/*.log

# 或使用 Web UI
rdagent ui --port 19899 --log-dir ~/quant/log/
```

### 3. 数据清理
```bash
# 清理临时文件
rm -rf ~/quant/log/__session__/*
# 清理 Qlib 缓存
rm -rf ~/data/qlib/cache/*
```

### 4. 环境重置
```bash
# 如果遇到问题，可以重置
conda deactivate
conda activate rdagent
pip install rdagent --force-reinstall
```

---

## 官方资源

| 资源 | 链接 |
|------|------|
| **官方文档** | https://rdagent.readthedocs.io/ |
| **GitHub** | https://github.com/microsoft/RD-Agent |
| **Qlib** | https://github.com/microsoft/qlib |
| **DeepSeek API** | https://platform.deepseek.com |
| **SiliconFlow** | https://www.siliconflow.cn |

---

## 相关 Skill

| Skill | 用途 |
|-------|------|
| **superpowers** | 软件开发工作流框架 |
| **brainstorming** | 头脑风暴和需求分析 |
| **writing-plans** | 制定开发计划 |
| **verification-before-completion** | 完成前验证 |

---

## 使用示例

### 示例1：运行综合量化研究
```bash
conda activate rdagent
source ~/system-logs/.env
cd ~/quant
rdagent fin_quant
```

### 示例2：只运行因子挖掘
```bash
conda activate rdagent
source ~/system-logs/.env
cd ~/quant
rdagent fin_factor
```

### 示例3：健康检查
```bash
conda activate rdagent
source ~/system-logs/.env
rdagent health_check
```

### 示例4：带日志查看
```bash
# 终端1：运行
rdagent fin_quant

# 终端2：查看日志
rdagent ui --port 19899 --log-dir ~/quant/log/
```

---

## 注意事项

1. **API Keys 安全**：
   - `.env` 文件已加密存储在 GitHub
   - 本地明文存储在 `~/system-logs/.env`
   - 不要分享你的 API keys

2. **Docker 权限**：
   - 确保用户已在 docker 组
   - `sudo usermod -aG docker $USER`

3. **数据库密码**：
   - 默认密码：`quant@2024`
   - 建议修改为更复杂的密码

4. **磁盘空间**：
   - Qlib 数据可能占用大量空间
   - 定期清理缓存

5. **网络连接**：
   - 需要稳定的网络连接 API
   - 确保代理配置正确（已配置）

---

## 快速参考

```bash
# 启动研究
conda activate rdagent
source ~/system-logs/.env
cd ~/quant
rdagent fin_quant

# 查看结果
rdagent ui --port 19899 --log-dir ~/quant/log/

# 检查状态
rdagent health_check

# 备份数据
~/system-logs/scripts/backup.sh
```

---

**最后更新**: 2026-02-12
**版本**: 1.0
