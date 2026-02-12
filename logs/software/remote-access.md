# 远程访问配置报告

## 配置日期
2026-02-13

## 配置目标
实现：电脑重启 → 自动登录 → RustDesk 自动启动 → 可远程连接

---

## 已完成的配置

### 1. 自动登录 ✅
**文件**: `/etc/gdm3/custom.conf`

```bash
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=zjh
```

**作用**: 开机时跳过登录界面，直接进入桌面

---

### 2. 锁屏保护 ✅

| 配置项 | 设置值 | 作用 |
|--------|--------|------|
| `idle-delay` | 900 (15分钟) | 闲置15分钟后触发锁屏 |
| `lock-enabled` | true | 启用自动锁屏 |
| `lock-delay` | 0 | 立即锁屏（无延迟） |

**命令**:
```bash
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver lock-delay uint32 0
```

---

### 3. RustDesk 开机自启动 ✅

**服务文件**: `~/.config/systemd/user/rustdesk.service`

```ini
[Unit]
Description=RustDesk Remote Desktop
After=graphical-session.target
Wants=graphical-session.target

[Service]
Type=simple
ExecStart=/home/zjh/下载/RustDesk-1.4.5-x86_64.AppImage
Restart=always
RestartSec=10
Environment=DISPLAY=:0
Environment=XDG_RUNTIME_DIR=/run/user/1000

[Install]
WantedBy=default.target
```

**服务状态**:
```bash
systemctl --user enable rustdesk.service  # 开机自启
systemctl --user start rustdesk.service   # 立即启动
systemctl --user status rustdesk.service  # 查看状态
```

---

## 使用流程

```
1. 电脑重启
   ↓
2. 自动登录（无需输入密码）
   ↓
3. 自动启动 RustDesk（后台运行）
   ↓
4. 闲置15分钟后
   ↓
5. 自动锁屏（显示登录界面）
   ↓
6. 远程连接 RustDesk
   ↓
7. 看到锁屏界面
   ↓
8. 输入密码解锁
   ↓
9. 开始使用！
```

---

## 安全性配置

| 安全措施 | 说明 |
|----------|------|
| **自动登录** | 开机时跳过登录（仅这次） |
| **自动锁屏** | 闲置15分钟后锁定 |
| **强密码** | 锁屏解锁 + 远程操作时使用 |
| **RustDesk 加密** | 端到端加密传输 |

---

## 验证命令

```bash
# 检查自动登录
grep AutomaticLogin /etc/gdm3/custom.conf

# 检查锁屏设置
gsettings get org.gnome.desktop.session idle-delay
gsettings get org.gnome.desktop.screensaver lock-enabled

# 检查 RustDesk 服务
systemctl --user is-enabled rustdesk
systemctl --user is-active rustdesk

# 检查 RustDesk 进程
ps aux | grep rustdesk
```

---

## 快速操作

```bash
# 重启后验证配置
~/check-remote-access.sh

# 查看 RustDesk ID
# 在 RustDesk 界面中查看主界面显示的 8位数字

# 从远程连接
# 1. 在另一台电脑安装 RustDesk
# 2. 输入你的 ID
# 3. 输入密码
# 4. 连接！
```

---

## 文件位置

| 文件 | 位置 |
|------|------|
| RustDesk 主程序 | `/home/zjh/下载/RustDesk-1.4.5-x86_64.AppImage` |
| 自动登录配置 | `/etc/gdm3/custom.conf` |
| RustDesk 服务 | `~/.config/systemd/user/rustdesk.service` |
| 配置脚本 | `~/setup-security.sh` |
| 检查脚本 | `~/check-remote-access.sh` |

---

## 故障排除

### 问题1：RustDesk 不自启动
```bash
# 检查服务状态
systemctl --user status rustdesk

# 重新启用服务
systemctl --user disable rustdesk
systemctl --user enable rustdesk
systemctl --user start rustdesk
```

### 问题2：锁屏不生效
```bash
# 重新设置锁屏
export DISPLAY=:0
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-enabled true
```

### 问题3：无法远程连接
```bash
# 检查 RustDesk 是否运行
ps aux | grep rustdesk

# 检查端口
ss -tlnp | grep 2111

# 重启 RustDesk 服务
systemctl --user restart rustdesk
```

---

## 相关文档

| 文档 | 位置 |
|------|------|
| **RustDesk 安装** | `~/system-logs/logs/software/rustdesk.md` |
| **RD-Agent Skill** | `~/system-logs/skills/rd-agent-usage/SKILL.md` |
| **系统日志** | `~/system-logs/` |

---

**最后更新**: 2026-02-13
**版本**: 1.0
