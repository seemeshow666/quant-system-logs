# Conda Installation Log

## Installation Date
2026-02-12

## Installation Command
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
```

## Environment
- Location: `/opt/miniconda3`
- Python Version: 3.10 (rdagent environment)

## RD-Agent Environment
```bash
conda create -n rdagent python=3.10 -y
conda activate rdagent
pip install rdagent
pip install qlib
```

## Important Commands
```bash
# Activate environment
conda activate rdagent

# Check environment info
conda info --envs

# List installed packages
conda list
```

## Notes
- Miniconda installed at system level: `/opt/miniconda3`
- User environment configuration in `~/.bashrc`
