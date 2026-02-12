#!/bin/bash

# 一键启动 RD-Agent
# 用法: ./start-rdagent.sh

set -e

echo "========================================"
echo "RD-Agent 启动器"
echo "========================================"
echo ""

# 加载环境变量
if [ -f ~/system-logs/.env ]; then
    echo "[1/4] 加载环境变量..."
    set -a
    source ~/system-logs/.env
    echo "   ✅ 环境变量已加载"
else
    echo "   ⚠️  未找到 ~/system-logs/.env"
fi

# 激活 Conda
if command -v conda &> /dev/null; then
    echo "[2/4] 激活 Conda 环境..."
    source /opt/miniconda3/etc/profile.d/conda.sh 2>/dev/null || true
    conda activate rdagent 2>/dev/null || echo "   ⚠️  Conda 激活失败，请手动执行: conda activate rdagent"
    echo "   ✅ Conda 环境准备就绪"
else
    echo "   ⚠️  未找到 Conda"
fi

# 检查目录
echo "[3/4] 检查目录..."
if [ -d ~/quant ]; then
    cd ~/quant
    echo "   ✅ 进入 ~/quant 目录"
else
    echo "   ⚠️  ~/quant 目录不存在"
fi

echo ""
echo "[4/4] 选择运行场景:"
echo ""
echo "  1. fin_quant  - 综合量化（因子 + 模型）"
echo "  2. fin_factor - 因子挖掘"
echo "  3. fin_model  - 模型优化"
echo "  4. health_check - 健康检查"
echo "  5. ui - 启动 Web UI"
echo ""
read -p "请输入数字 (1-5): " choice

echo ""
echo "========================================"
echo "正在启动 RD-Agent..."
echo "========================================"

case $choice in
    1)
        echo "运行: rdagent fin_quant"
        rdagent fin_quant
        ;;
    2)
        echo "运行: rdagent fin_factor"
        rdagent fin_factor
        ;;
    3)
        echo "运行: rdagent fin_model"
        rdagent fin_model
        ;;
    4)
        echo "运行: rdagent health_check"
        rdagent health_check
        ;;
    5)
        echo "运行: rdagent ui --port 19899 --log-dir ~/quant/log/"
        rdagent ui --port 19899 --log-dir ~/quant/log/
        ;;
    *)
        echo "无效选择，请输入 1-5"
        exit 1
        ;;
esac
