# RD-Agent Installation Log

## Installation Date
2026-02-12

## Installation Steps

### 1. Create Conda Environment
```bash
conda create -n rdagent python=3.10 -y
conda activate rdagent
```

### 2. Install RD-Agent
```bash
pip install rdagent
```

### 3. Install Qlib
```bash
pip install qlib
```

## Version Information
- RD-Agent: 0.8.0
- Qlib: 0.0.2.dev20
- Python: 3.10

## Usage

### Start RD-Agent
```bash
conda activate rdagent
rdagent fin_quant
```

### Health Check
```bash
rdagent health_check
```

## Scenarios Available
- `rdagent fin_quant` - 综合量化（因子 + 模型）
- `rdagent fin_factor` - 因子挖掘
- `rdagent fin_model` - 模型优化
- `rdagent data_science` - 数据科学

## Configuration
Configure LLM settings in `~/system-logs/.env`

## Notes
- RD-Agent requires LLM API keys (DeepSeek + SiliconFlow)
- Docker is required for scenario validation
- Qlib is installed for quantitative analysis
