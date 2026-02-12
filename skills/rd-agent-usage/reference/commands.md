# RD-Agent 命令参考

## 常用命令速查

| 命令 | 描述 | 示例 |
|------|------|------|
| `rdagent fin_quant` | 综合量化研究 | `rdagent fin_quant` |
| `rdagent fin_factor` | 因子挖掘 | `rdagent fin_factor` |
| `rdagent fin_model` | 模型优化 | `rdagent fin_model` |
| `rdagent health_check` | 健康检查 | `rdagent health_check` |
| `rdagent ui` | 启动 Web UI | `rdagent ui --port 19899` |
| `rdagent fin_factor_report` | 从报告提取因子 | `rdagent fin_factor_report --report-folder=./reports` |
| `rdagent general_model` | 从论文实现模型 | `rdagent general_model https://arxiv.org/abs/xxxxx` |
| `rdagent data_science` | 数据科学研究 | `rdagent data_science --competition kaggle-competition` |

## 参数说明

### fin_quant
```
无必需参数
```

### fin_factor
```
无必需参数
```

### fin_model
```
无必需参数
```

### ui
```
--port <端口>    端口号，默认 19899
--log-dir <路径> 日志目录
--data-science  显示数据科学场景日志
```

### fin_factor_report
```
--report-folder <路径>  财务报告文件夹路径
```

### general_model
```
<paper_url>  论文或报告的 URL
```

### data_science
```
--competition <名称>  竞赛名称
--path <路径>         会话路径
--loop_n <数量>       循环次数
--step_n <数量>       步骤数
```

## 环境变量

### 必需配置
```bash
# LLM 配置
CHAT_MODEL=deepseek/deepseek-chat
DEEPSEEK_API_KEY=sk-xxx
EMBEDDING_MODEL=litellm_proxy/BAAI/bge-m3
LITELLM_PROXY_API_KEY=sk-xxx
LITELLM_PROXY_API_BASE=https://api.siliconflow.cn/v1
```

### 可选配置
```bash
# 执行环境
MODEL_COSTEER_ENV_TYPE=docker    # 或 conda
DS_CODER_COSTEER_ENV_TYPE=docker  # 或 conda

# 时间段配置 (fin_factor)
QLIB_FACTOR_TRAIN_START=2008-01-01
QLIB_FACTOR_TRAIN_END=2014-12-31
QLIB_FACTOR_VALID_START=2015-01-01
QLIB_FACTOR_VALID_END=2016-12-31
QLIB_FACTOR_TEST_START=2017-01-01
QLIB_FACTOR_TEST_END=2020-12-31

# 时间段配置 (fin_model)
QLIB_MODEL_TRAIN_START=2008-01-01
QLIB_MODEL_TRAIN_END=2014-12-31
QLIB_MODEL_VALID_START=2015-01-01
QLIB_MODEL_VALID_END=2016-12-31
QLIB_MODEL_TEST_START=2017-01-01
QLIB_MODEL_TEST_END=2020-12-31
```

## 快捷方式

```bash
# 激活并运行
alias rdagent-start='conda activate rdagent && source ~/system-logs/.env && cd ~/quant'
alias rdagent-check='rdagent health_check'
alias rdagent-web='rdagent ui --port 19899 --log-dir ~/quant/log/'

# 使用
rdagent-start
rdagent fin_quant
```

## 输出位置

| 类型 | 路径 |
|------|------|
| 日志 | `~/quant/log/` |
| 数据 | `~/data/qlib/` |
| 项目 | `~/quant/projects/` |
| 备份 | `~/system-logs/backups/` |

## 常见错误

| 错误 | 解决方案 |
|------|----------|
| `command not found: rdagent` | `conda activate rdagent` |
| `API key 无效` | 检查 `~/system-logs/.env` |
| `Docker permission denied` | `sudo usermod -aG docker $USER` |
| `Port occupied` | 更换端口或停止占用进程 |
