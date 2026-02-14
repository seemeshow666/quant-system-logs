# TradingAgents-CN 安装报告

## 安装日期
2026-02-14

## 安装状态
✅ 已完成

## 软件信息

| 项目 | 内容 |
|------|------|
| **软件名称** | TradingAgents-CN |
| **版本** | v1.0.0-preview |
| **类型** | 多智能体 LLM 金融交易框架 |
| **安装位置** | `~/tradingagents` |

## 已安装组件

| 组件 | 版本 | 说明 |
|------|------|------|
| **TradingAgents** | v1.0.0-preview | 主程序 |
| **MongoDB** | 7.0.5 | 数据库 |
| **Redis** | 7.0.15 | 缓存 |
| **Python 包** | 见 requirements.txt | 依赖库 |

## 配置文件

| 文件 | 位置 | 说明 |
|------|------|------|
| **环境变量** | `~/tradingagents/.env` | API 密钥和配置 |
| **启动脚本** | `~/start-tradingagents.sh` | 一键启动 |
| **日志目录** | `~/tradingagents/logs` | 运行日志 |
| **数据目录** | `~/tradingagents/data` | 股票数据 |

## 启动方式

### 方法1：使用启动脚本（推荐）
```bash
~/start-tradingagents.sh
```

### 方法2：手动启动
```bash
# 1. 启动数据库
echo 'zxcv' | sudo -S systemctl start redis-server
mongod --fork --logpath ~/tradingagents/logs/mongodb.log

# 2. 激活环境
conda activate rdagent

# 3. 启动 TradingAgents
cd ~/tradingagents
python -m cli.main
```

## 核心功能

### 1. 多智能体分析
- **市场分析师 (Market Analyst)**: 技术分析、趋势识别
- **基本面分析师 (Fundamentals Analyst)**: 财务报表、估值分析
- **情绪分析师 (Sentiment Analyst)**: 新闻情绪、社交媒体
- **研究团队 (Research Team)**: 综合多维度分析
- **交易员 (Trader)**: 生成交易策略
- **风险管理 (Risk Manager)**: 风险评估
- **投资组合管理 (Portfolio Manager)**: 资产配置

### 2. 支持市场
- **A股**: 中国平安、贵州茅台等
- **美股**: SPY, AAPL, TSLA 等
- **港股**: 腾讯、阿里巴巴等

### 3. 数据源
- **AKShare**: 免费 A 股数据（默认）
- **Tushare**: 专业 A 股数据
- **BaoStock**: 免费股票数据
- **FinnHub**: 美股数据

### 4. LLM 提供商
- ✅ **DeepSeek** (已配置)
- ✅ **硅基流动** (已配置)
- **通义千问** (可选)
- **OpenAI** (可选)
- **Gemini** (可选)

## 使用流程

### 步骤1：启动 TradingAgents
```bash
~/start-tradingagents.sh
```

### 步骤2：选择市场
- 输入 `1` 选择美股
- 输入 `2` 选择 A 股（默认）
- 输入 `3` 选择港股

### 步骤3：输入股票代码
- A 股: `000001` (平安银行), `600036` (招商银行)
- 美股: `AAPL`, `TSLA`
- 港股: `0700.HK` (腾讯)

### 步骤4：选择分析师团队
- 选择要使用的分析师类型
- 建议全选以获得最全面的分析

### 步骤5：等待分析完成
- 系统会自动调用多个 AI Agent
- 分析时间取决于股票复杂度和网络状况

### 步骤6：查看报告
- 分析完成后会生成详细报告
- 支持 Markdown/Word/PDF 导出

## 与 RD-Agent 的协同

| 工具 | 用途 | 适用场景 |
|------|------|----------|
| **RD-Agent** | 深度因子研究、模型优化 | 学术研究、策略开发 |
| **TradingAgents** | 快速多维度分析、日常监控 | 日常交易、快速决策 |

### 数据共享
- 两者都可以使用 AKShare/Tushare 数据
- TradingAgents 的分析结果可作为 RD-Agent 的输入
- 建议先用 TradingAgents 快速筛选，再用 RD-Agent 深度研究

## 故障排除

### 问题1：数据库连接失败
```bash
# 检查 Redis
redis-cli ping
# 应该返回: PONG

# 检查 MongoDB
mongosh --eval "db.version()"
# 应该返回版本号
```

### 问题2：API 密钥错误
```bash
# 检查环境变量
cat ~/tradingagents/.env | grep -E "DEEPSEEK|SILICONFLOW"
```

### 问题3：数据源获取失败
```bash
# 测试 AKShare
python -c "import akshare as ak; print(ak.stock_zh_a_spot_em())"
```

## 配置文件示例

```bash
# ~/tradingagents/.env

# DeepSeek API
DEEPSEEK_API_KEY=sk-04125e95243f472783106e7cf55f3a98
DEEPSEEK_BASE_URL=https://api.deepseek.com
DEEPSEEK_ENABLED=true

# 硅基流动 API
SILICONFLOW_API_KEY=sk-ouxazhgwwwwftzkheuhthdmtoateefteuhxsmfjfjksqkzex

# 数据源
DEFAULT_CHINA_DATA_SOURCE=akshare

# 数据库
MONGODB_HOST=localhost
MONGODB_PORT=27017
REDIS_HOST=localhost
REDIS_PORT=6379
```

## 目录结构

```
~/tradingagents/
├── app/                    # FastAPI 后端（需授权）
├── cli/                    # CLI 工具 ✅ 可用
├── config/                 # 配置文件
├── data/                   # 数据目录
├── docs/                   # 文档
├── frontend/               # Vue 前端（需授权）
├── logs/                   # 日志目录
├── tradingagents/          # 核心库
├── .env                    # 环境变量 ✅
└── requirements.txt        # 依赖列表
```

## 相关文档

- **官方文档**: https://github.com/hsliuping/TradingAgents-CN/tree/main/docs
- **GitHub**: https://github.com/hsliuping/TradingAgents-CN
- **微信公众号**: TradingAgents-CN

## 与系统日志的关系

| 项目 | 位置 |
|------|------|
| **TradingAgents** | `~/tradingagents/` |
| **RD-Agent** | `~/quant/` |
| **系统日志** | `~/system-logs/` |
| **GitHub 备份** | https://github.com/seemeshow666/quant-system-logs |

## 快速命令

```bash
# 启动 TradingAgents
~/start-tradingagents.sh

# 查看日志
tail -f ~/tradingagents/logs/*.log

# 检查数据库
redis-cli ping
mongosh --eval "db.version()"

# 检查进程
ps aux | grep -E "redis|mongo|tradingagents"

# 停止所有服务
pkill -f "mongod|redis-server|python.*cli.main"
```

## 注意事项

1. **许可证**: v1.0.0-preview 个人使用免费，商业使用需授权
2. **数据限制**: AKShare 免费但有频率限制，Tushare 需要积分
3. **API 费用**: DeepSeek 调用会产生费用，请注意用量
4. **风险提示**: AI 分析仅供参考，不构成投资建议

## 技术支持

- **GitHub Issues**: https://github.com/hsliuping/TradingAgents-CN/issues
- **邮箱**: hsliup@163.com
- **微信公众号**: TradingAgents-CN

---

**最后更新**: 2026-02-14
**版本**: 1.0
