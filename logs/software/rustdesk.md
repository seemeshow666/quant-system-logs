# RustDesk 安装与配置报告

## 安装日期
2026-02-12

## 安装状态
✅ 已安装

## 软件信息

| 项目 | 内容 |
|------|------|
| **软件名称** | RustDesk |
| **版本** | 1.4.5 |
| **类型** | AppImage (便携式) |
| **大小** | 82 MB |
| **安装位置** | `/home/zjh/下载/RustDesk-1.4.5-x86_64.AppImage` |

## 安装文件

| 文件 | 位置 | 说明 |
|------|------|------|
| **主程序** | `~/下载/RustDesk-1.4.5-x86_64.AppImage` | RustDesk 可执行文件 |
| **桌面图标** | `~/.local/share/applications/rustdesk.desktop` | 应用程序菜单图标 |
| **启动脚本** | `~/start-rustdesk.sh` | 一键启动脚本 |
| **配置文件** | `~/.config/rustdesk/rustdesk.yml` | 配置目录 |

## 使用方法

### 方法1：应用菜单
1. 按 `Super` 键（Windows 键）
2. 搜索 **"RustDesk"**
3. 点击打开

### 方法2：终端启动
```bash
~/start-rustdesk.sh
```

### 方法3：直接运行
```bash
"/home/zjh/下载/RustDesk-1.4.5-x86_64.AppImage"
```

## 初始配置步骤

### 步骤 1：设置连接密码（必须）

1. **启动 RustDesk**
2. **点击右上角菜单**（三个点图标）
3. **选择 "设置"**
4. **找到 "安全" 或 "密码" 选项**
5. **启用 "需要密码"**
6. **设置连接密码**（建议：8位以上，包含字母和数字）

### 步骤 2：记录 RustDesk ID

启动后，主界面会显示你的 **8位数字 ID**（例如：`1234 5678`）

**重要**：记录这个 ID，远程连接时需要用到！

### 步骤 3：从远程电脑连接

#### Windows / Mac 客户端
1. 下载 RustDesk：https://github.com/rustdesk/rustdesk/releases
2. 安装并运行
3. 输入你的 **ID**（8位数字）
4. 输入**密码**
5. 点击连接

#### 连接成功后会看到你的桌面！

## 安全配置（中等安全）

| 安全选项 | 设置 | 说明 |
|----------|------|------|
| **连接密码** | ✅ 启用 | 必须输入密码才能连接 |
| **ID 验证** | ✅ 启用 | ID + 密码双重验证 |
| **端到端加密** | ✅ 默认 | 自动加密所有传输 |
| **隐私模式** | 可选 | 可隐藏桌面内容 |

## 配置文件位置

| 配置项 | 路径 |
|--------|------|
| **RustDesk 配置** | `~/.config/rustdesk/rustdesk.yml` |
| **日志文件** | `~/.config/rustdesk/logs/` |
| **快捷键** | `~/.config/rustdesk/shortcuts.yml` |

## 功能特性

| 功能 | 支持情况 | 说明 |
|------|----------|------|
| **远程桌面控制** | ✅ | 完整控制鼠标和键盘 |
| **文件传输** | ✅ | 可在电脑间传输文件 |
| **剪贴板共享** | ✅ | 复制粘贴跨设备 |
| **端到端加密** | ✅ | 高安全性加密 |
| **多显示器支持** | ✅ | 自动识别多个显示器 |
| **语音通话** | ✅ | 可选语音沟通 |
| **录屏功能** | ✅ | 可录制远程会话 |

## 故障排除

### 问题1：无法连接
**可能原因**：ID 错误或密码错误
**解决**：
- 确认 ID 输入正确（8位数字）
- 确认密码正确

### 问题2：连接缓慢
**可能原因**：网络延迟
**解决**：
- 确保双方网络稳定
- 尝试关闭其他占用带宽的程序

### 问题3：黑屏
**可能原因**：隐私模式或权限问题
**解决**：
- 关闭隐私模式
- 检查屏幕共享权限

### 问题4：鼠标不同步
**可能原因**：客户端问题
**解决**：
- 重启 RustDesk
- 检查网络连接

## 高级配置

### 使用自建 ID 服务器（可选）

如果需要更高的隐私性，可以配置自建服务器：

```yaml
# ~/.config/rustdesk/rustdesk.yml
rustdesk_server: your-server-ip:21117
```

### 配置代理

如果需要通过代理连接：

```yaml
# 在设置中配置代理地址
proxy_server: http://proxy:port
```

## 开机自启（可选）

如果需要开机自动运行：

```bash
# 创建自启动链接
mkdir -p ~/.config/autostart
cp ~/.local/share/applications/rustdesk.desktop ~/.config/autostart/
```

## 与 Superpowers 的关系

| 项目 | 用途 |
|------|------|
| **RustDesk** | 远程图形界面访问 |
| **Superpowers** | 软件开发工作流程 |
| **rd-agent-usage** | RD-Agent 使用指南 |

## 相关文档

| 文档 | 位置 |
|------|------|
| **RD-Agent Skill** | `~/system-logs/skills/rd-agent-usage/SKILL.md` |
| **系统日志** | `~/system-logs/` |
| **量化系统** | `~/quant/` |

## 技术支持

- **RustDesk 官网**: https://rustdesk.com/
- **GitHub**: https://github.com/rustdesk/rustdesk
- **官方文档**: https://rustdesk.com/docs/

## 快速参考

```bash
# 启动 RustDesk
~/start-rustdesk.sh

# 查看配置文件
cat ~/.config/rustdesk/rustdesk.yml

# 重启 RustDesk
pkill rustdesk
~/start-rustdesk.sh
```

## 注意事项

1. **密码安全**：不要使用简单密码，建议 12 位以上
2. **ID 保密**：不要随意分享你的 ID，除非需要远程协助
3. **网络要求**：需要稳定的网络连接
4. **防火墙**：确保防火墙允许 RustDesk 端口

## 安装验证

| 检查项 | 状态 |
|--------|------|
| AppImage 下载成功 | ✅ |
| 桌面图标创建 | ✅ |
| 启动脚本创建 | ✅ |
| 配置文件创建 | ✅ |
| 可从应用菜单启动 | ✅ |

---

**最后更新**: 2026-02-12
**版本**: 1.0
