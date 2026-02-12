# 🔐 Git-Crypt 解密指南

## 重要：解密密钥文件

仓库中的 `.env` 文件已使用 git-crypt 加密。要在新电脑上解密，你需要使用 git-crypt 对称密钥。

---

## 方法 1：使用仓库中的密钥文件

### 步骤 1：克隆仓库
```bash
git clone https://github.com/seemeshow666/quant-system-logs.git ~/system-logs
cd ~/system-logs
```

### 步骤 2：解密文件
```bash
# 解密所有加密文件
git-crypt unlock

# 或者使用对称密钥文件
git-crypt unlock .git/git-crypt/keys/default
```

---

## 方法 2：使用备份的密钥文件

### 步骤 1：复制密钥文件
将备份的 `git-crypt-key` 文件复制到新电脑的 `~/system-logs/.git/git-crypt/keys/default`

```bash
# 在新电脑上
mkdir -p ~/system-logs/.git/git-crypt/keys/
cp /path/to/git-crypt-key ~/system-logs/.git/git-crypt/keys/default
chmod 600 ~/system-logs/.git/git-crypt/keys/default
```

### 步骤 2：解密
```bash
cd ~/system-logs
git-crypt unlock .git/git-crypt/keys/default
```

---

## 方法 3：使用 GPG（推荐，更安全）

### 步骤 1：生成 GPG 密钥
```bash
gpg --full-generate-key
# 选择：
# - Key type: RSA and RSA
# - Key length: 4096
# - Expire: 0 (never)
# - Email: quant@localhost
```

### 步骤 2：备份 GPG 私钥
```bash
# 导出私钥
gpg --armor --export-secret-keys quant@localhost > ~/gpg-private-key.asc

# 妥善保管这个文件！
```

### 步骤 4：解密
```bash
cd ~/system-logs
git-crypt unlock
```

---

## 验证解密成功

解密后，检查 `.env` 文件：
```bash
cat .env
```

如果看到明文的 API keys，说明解密成功：
```bash
DEEPSEEK_API_KEY=sk-04125e95243f472783106e7cf55f3a98
LITELLM_PROXY_API_KEY=sk-ouxazhgwwwwftzkheuhthdmtoateefteuhxsmfjfjksqkzex
```

---

## 常见问题

### Q: 解密时提示 "no GPG secret key available"
**A**: 这是因为仓库使用了对称密钥而不是 GPG。使用命令：
```bash
git-crypt unlock .git/git-crypt/keys/default
```

### Q: 密钥文件丢失怎么办？
**A**: 
1. 如果有 GPG 密钥，可以用 GPG 解密
2. 如果都没有，只能重新生成密钥并重新加密文件

### Q: 如何在新电脑上解密？
**A**: 按照上面的"方法 1"或"方法 2"操作即可。

---

## ⚠️ 重要提醒

1. **备份密钥**：将 `~/system-logs/.git/git-crypt/keys/default` 文件备份到安全位置（如 U 盘）
2. **不要上传密钥到 GitHub**：密钥文件已加入 `.gitignore`
3. **GPG 更安全**：建议使用 GPG 方式，密钥可以导出并在不同电脑上使用

---

## 相关信息

- **GitHub 仓库**: https://github.com/seemeshow666/quant-system-logs
- **密钥类型**: git-crypt 对称密钥
- **加密文件**: `.env`, `.env.example`
