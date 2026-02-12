#!/bin/bash

# Restore Script for Quant System
# Usage: ./restore.sh [backup_file.tar.gz]
# If no backup file specified, uses latest backup

set -e  # Exit on error

BACKUP_DIR=~/system-logs/backups
LOG_FILE=~/system-logs/logs/restore.log
ENV_FILE=~/system-logs/.env

echo "========================================" | tee -a $LOG_FILE
echo "Restore started at $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# Check if .env exists and has API keys
if [ ! -f "$ENV_FILE" ] || ! grep -q "DEEPSEEK_API_KEY=sk-" "$ENV_FILE"; then
    echo "⚠️  WARNING: .env file missing or incomplete!" | tee -a $LOG_FILE
    echo "Please copy .env.example to .env and fill in your API keys" | tee -a $LOG_FILE
    echo "File: ~/system-logs/.env.example → ~/system-logs/.env" | tee -a $LOG_FILE
    echo "========================================" | tee -a $LOG_FILE
fi

# 1. Install system dependencies
echo "[1/6] Installing system dependencies..." | tee -a $LOG_FILE
echo 'zxcv' | sudo -S apt-get update -qq 2>&1 | tee -a $LOG_FILE
echo 'zxcv' | sudo -S apt-get install -y wget curl git git-crypt mysql-server mysql-client docker.io -qq 2>&1 | tee -a $LOG_FILE

# 2. Install Miniconda
echo "[2/6] Installing Miniconda..." | tee -a $LOG_FILE
if [ ! -d "/opt/miniconda3" ]; then
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh 2>&1 | tee -a $LOG_FILE
    echo 'zxcv' | sudo -S bash /tmp/miniconda.sh -b -p /opt/miniconda3 2>&1 | tee -a $LOG_FILE
    bash --login -c '/opt/miniconda3/bin/conda init bash' 2>&1 | tee -a $LOG_FILE
    rm /tmp/miniconda.sh
else
    echo "Miniconda already installed, skipping..." | tee -a $LOG_FILE
fi

# 3. Create Conda environment and install packages
echo "[3/6] Setting up RD-Agent environment..." | tee -a $LOG_FILE
bash --login -c 'source /opt/miniconda3/etc/profile.d/conda.sh && conda activate base && conda env remove -n rdagent -y' 2>&1 | tee -a $LOG_FILE
bash --login -c 'source /opt/miniconda3/etc/profile.d/conda.sh && conda create -n rdagent python=3.10 -y' 2>&1 | tee -a $LOG_FILE
bash --login -c 'source /opt/miniconda3/etc/profile.d/conda.sh && conda activate rdagent && pip install rdagent qlib' 2>&1 | tee -a $LOG_FILE

# 4. Configure MySQL
echo "[4/6] Configuring MySQL..." | tee -a $LOG_FILE
echo 'zxcv' | sudo -S systemctl start mysql 2>&1 | tee -a $LOG_FILE
echo 'zxcv' | sudo -S mysql -e "CREATE DATABASE IF NOT EXISTS quant_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>&1 | tee -a $LOG_FILE
echo 'zxcv' | sudo -S mysql -e "CREATE USER IF NOT EXISTS 'quant_user'@'localhost' IDENTIFIED BY 'quant@2024';" 2>&1 | tee -a $LOG_FILE
echo 'zxcv' | sudo -S mysql -e "GRANT ALL PRIVILEGES ON quant_db.* TO 'quant_user'@'localhost';" 2>&1 | tee -a $LOG_FILE
echo 'zxcv' | sudo -S mysql -e "FLUSH PRIVILEGES;" 2>&1 | tee -a $LOG_FILE

# 5. Start Docker
echo "[5/6] Starting Docker..." | tee -a $LOG_FILE
echo 'zxcv' | sudo -S systemctl start docker 2>&1 | tee -a $LOG_FILE
echo 'zxcv' | sudo -S usermod -aG docker $USER 2>&1 | tee -a $LOG_FILE

# 6. Create directory structure
echo "[6/6] Creating directory structure..." | tee -a $LOG_FILE
mkdir -p ~/data/qlib/{bin,source,cache} ~/data/csv ~/data/database ~/quant/projects

echo "========================================" | tee -a $LOG_FILE
echo "✅ Restore completed!" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "" | tee -a $LOG_FILE
echo "Next steps:" | tee -a $LOG_FILE
echo "1. Configure LLM API keys in ~/system-logs/.env" | tee -a $LOG_FILE
echo "2. Restart terminal or run: source ~/.bashrc" | tee -a $LOG_FILE
echo "3. Activate environment: conda activate rdagent" | tee -a $LOG_FILE
echo "4. Start RD-Agent: rdagent fin_quant" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
