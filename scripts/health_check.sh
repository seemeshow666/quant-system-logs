#!/bin/bash

# Health Check Script for Quant System
# Usage: ./health_check.sh

echo "========================================"
echo "Quant System Health Check"
echo "========================================"
echo ""

# 1. Check Conda
echo "[1/5] Conda Environment"
if command -v conda &> /dev/null; then
    CONDA_VERSION=$(conda --version 2>/dev/null || echo "error")
    echo "  ✅ Conda: $CONDA_VERSION"
    
    if conda info --envs 2>/dev/null | grep -q "rdagent"; then
        echo "  ✅ rdagent environment exists"
        bash --login -c 'source /opt/miniconda3/etc/profile.d/conda.sh && conda activate rdagent && rdagent --version 2>/dev/null && echo "  ✅ RD-Agent installed"' || echo "  ❌ RD-Agent not found"
    else
        echo "  ❌ rdagent environment not found"
    fi
else
    echo "  ❌ Conda not installed"
fi
echo ""

# 2. Check MySQL
echo "[2/5] MySQL Database"
if command -v mysql &> /dev/null; then
    if mysql -u root -p'quant@2024' -e "SHOW DATABASES;" 2>/dev/null | grep -q "quant_db"; then
        echo "  ✅ MySQL running, quant_db exists"
    else
        echo "  ⚠️  MySQL installed but quant_db not found"
    fi
else
    echo "  ❌ MySQL not installed"
fi
echo ""

# 3. Check Docker
echo "[3/5] Docker"
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version 2>/dev/null || echo "error")
    echo "  ✅ Docker: $DOCKER_VERSION"
    
    if docker ps 2>/dev/null | head -1 | grep -q "CONTAINER"; then
        echo "  ✅ Docker daemon running"
    else
        echo "  ⚠️  Docker installed but daemon not running"
    fi
else
    echo "  ❌ Docker not installed"
fi
echo ""

# 4. Check Directories
echo "[4/5] Directories"
for dir in ~/data ~/quant ~/system-logs; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir exists"
    else
        echo "  ❌ $dir not found"
    fi
done
echo ""

# 5. Check Configuration
echo "[5/5] Configuration"
if [ -f ~/system-logs/.env ]; then
    if grep -q "DEEPSEEK_API_KEY=sk-" ~/system-logs/.env; then
        echo "  ✅ .env configured with DeepSeek API key"
    else
        echo "  ⚠️  .env exists but API key not configured"
    fi
else
    echo "  ❌ .env file not found"
fi

echo ""
echo "========================================"
echo "Health check completed!"
echo "========================================"
