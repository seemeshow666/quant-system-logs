# RD-Agent Usage Skill

## 简介

本 skill 提供 RD-Agent 量化交易 AI 代理系统的完整使用指南。

## 使用方法

### 方式1：查看 Skill 文档
直接阅读 `SKILL.md` 文件，了解所有命令和用法。

### 方式2：使用辅助脚本
```bash
# 一键启动 RD-Agent
~/system-logs/skills/rd-agent-usage/scripts/start-rdagent.sh

# 健康检查
~/system-logs/skills/rd-agent-usage/scripts/health-check.sh
```

## 快速开始

```bash
# 1. 激活环境
conda activate rdagent

# 2. 加载配置
source ~/system-logs/.env

# 3. 运行研究
rdagent fin_quant
```

## 核心命令

| 命令 | 用途 |
|------|------|
| `rdagent fin_quant` | 综合量化（因子 + 模型） |
| `rdagent fin_factor` | 因子挖掘 |
| `rdagent fin_model` | 模型优化 |
| `rdagent health_check` | 健康检查 |
| `rdagent ui` | Web UI |

## 文件结构

```
rd-agent-usage/
├── SKILL.md              # 主文档
├── README.md             # 本文件
├── scripts/
│   ├── start-rdagent.sh  # 一键启动脚本
│   └── health-check.sh   # 健康检查脚本
└── reference/
    └── commands.md       # 命令参考
```

## 相关资源

- [RD-Agent 官方文档](https://rdagent.readthedocs.io/)
- [GitHub 仓库](https://github.com/microsoft/RD-Agent)
- [Qlib 量化平台](https://github.com/microsoft/qlib)

## 系统日志

本 skill 存放在 `~/system-logs/skills/rd-agent-usage/`，已纳入 Git 版本控制。
