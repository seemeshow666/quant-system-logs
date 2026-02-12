#!/bin/bash

# RD-Agent 健康检查
# 用法: ./health-check.sh

echo "========================================"
echo "RD-Agent 健康检查"
echo "========================================"
echo ""

# 1. 检查 Conda
echo "[1/6] 检查 Conda 环境..."
if command -v conda &> /dev/null; then
    CONDA_VERSION=$(conda --version 2>/dev/null || echo "未知")
    echo "  ✅ Conda: $CONDA_VERSION"
    
    if conda info --envs 2>/dev/null | grep -q "rdagent"; then
        echo "  ✅ rdagent 环境存在"
    else
        echo "  ❌ rdagent 环境不存在"
    fi
else
    echo "  ❌ Conda 未安装"
fi
echo ""

# 2. 检查 RD-Agent
echo "[2/6] 检查 RD-Agent..."
if command -v rdagent &> /dev/null; then
    echo "  ✅ RD-Agent 已安装"
else
    echo "  ❌ RD-Agent 未安装，请运行: pip install rdagent"
fi
echo ""

# 3. 检查环境变量
echo "[3/6] 检查环境变量..."
if [ -f ~/system-logs/.env ]; then
    source ~/system-logs/.env
    
    if [ -n "$DEEPSEEK_API_KEY" ]; then
        echo "  ✅ DeepSeek API Key 已配置"
    else
        echo "  ❌ DeepSeek API Key 未配置"
    fi
    
    if [ -n "$LITELLM_PROXY_API_KEY" ]; then
        echo "  ✅ SiliconFlow API Key 已配置"
    else
        echo "  ❌ SiliconFlow API Key 未配置"
    fi
else
    echo "  ❌ ~/system-logs/.env 不存在"
fi
echo ""

# 4. 检查 MySQL
echo "[4/6] 检查 MySQL..."
if command -v mysql &> /dev/null; then
    if mysql -u quant_user -p'quant@2024' -e "SELECT 1;" 2>/dev/null | grep -q "1"; then
        echo "  ✅ MySQL 连接正常"
    else
        echo "  ⚠️  MySQL 连接失败，请检查数据库服务"
    fi
else
    echo "  ❌ MySQL 未安装"
fi
echo ""

# 5. 检查 Docker
echo "[5/6] 检查 Docker..."
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version 2>/dev/null || echo "未知")
    echo "  ✅ Docker: $DOCKER_VERSION"
    
    if docker ps 2>/dev/null | head -1 | grep -q "CONTAINER"; then
        echo "  ✅ Docker daemon 运行中"
    else
        echo "  ⚠️  Docker daemon 未运行（可手动启动: sudo systemctl start docker）"
    fi
else
    echo "  ❌ Docker 未安装"
fi
echo ""

# 6. 检查目录
echo "[6/6] 检查目录..."
for dir in ~/quant ~/data ~/system-logs; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir 存在"
    else
        echo "  ❌ $dir 不存在"
    fi
done
echo ""

echo "========================================"
echo "健康检查完成！"
echo "========================================"
echo ""
echo "提示："
echo "- 如需完整检查，运行: rdagent health_check"
echo "- 配置文件位置: ~/system-logs/.env"
echo "- 项目目录: ~/quant"
echo ""
