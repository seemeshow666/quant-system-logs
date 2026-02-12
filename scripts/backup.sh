#!/bin/bash

# Backup Script for Quant System
# Usage: ./backup.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/system-logs/backups
LOG_FILE=~/system-logs/logs/backup.log

# Create backup directory
mkdir -p $BACKUP_DIR

echo "========================================" | tee -a $LOG_FILE
echo "Backup started at $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# 1. Backup Conda environment
echo "[1/5] Backing up Conda environment..." | tee -a $LOG_FILE
bash --login -c "source /opt/miniconda3/etc/profile.d/conda.sh && conda activate rdagent && conda env export -n rdagent > $BACKUP_DIR/conda_rdagent_$DATE.yml" 2>&1 | tee -a $LOG_FILE

# 2. Backup MySQL database
echo "[2/5] Backing up MySQL database..." | tee -a $LOG_FILE
mysqldump -u root -p'quant@2024' quant_db > $BACKUP_DIR/mysql_quant_db_$DATE.sql 2>&1 | tee -a $LOG_FILE

# 3. Backup configuration files
echo "[3/5] Backing up configuration files..." | tee -a $LOG_FILE
cp ~/.condarc $BACKUP_DIR/condarc_$DATE 2>/dev/null || echo "No .condarc found"
cp ~/.bashrc $BACKUP_DIR/bashrc_$DATE 2>/dev/null || echo "No .bashrc found"
cp ~/system-logs/.env.example $BACKUP_DIR/env_example_$DATE 2>/dev/null || echo "No .env.example found"

# 4. Backup system-logs repository
echo "[4/5] Backing up system-logs repository..." | tee -a $LOG_FILE
cd ~/system-logs
if [ -d .git ]; then
    git add -A
    git commit -m "Auto backup: $DATE" 2>&1 | tee -a $LOG_FILE || echo "No changes to commit"
else
    echo "Not a git repository, skipping git backup" | tee -a $LOG_FILE
fi

# 5. Create compressed archive
echo "[5/5] Creating compressed archive..." | tee -a $LOG_FILE
tar -czf $BACKUP_DIR/full_backup_$DATE.tar.gz \
    --exclude='.git' \
    --exclude='backups' \
    -C ~/ system-logs/ 2>&1 | tee -a $LOG_FILE

echo "========================================" | tee -a $LOG_FILE
echo "Backup completed at $(date)" | tee -a $LOG_FILE
echo "Backup files:" | tee -a $LOG_FILE
ls -lh $BACKUP_DIR/*_$DATE* 2>/dev/null | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
