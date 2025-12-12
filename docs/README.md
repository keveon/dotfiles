# 🏠 Keveon's Dotfiles

一个功能强大、跨平台的 Dotfiles 配置管理系统，基于 [Chezmoi](https://www.chezmoi.io/) 实现，支持 macOS 和 Linux 系统。

## ✨ 特性

- 🚀 **一键安装** - 自动化安装脚本，快速部署开发环境
- 🔄 **跨平台支持** - 统一配置，适配 macOS 和 Linux
- 🛠️ **丰富的工具集** - 预配置 30+ 常用开发工具
- 🎨 **现代化终端** - 精美的 Zsh 配置和主题
- 📦 **智能包管理** - macOS 使用 Homebrew，Linux 使用 Mise
- 🔧 **自动补全** - 所有工具自动配置 Zsh 补全
- 🎯 **配置灵活** - 支持 Chezmoi 模板系统，轻松自定义

## 🚀 快速开始

### 安装

```bash
# 使用默认配置安装
curl -fsSL https://dotfiles.keveon.io/install.sh | sh

# 或使用自定义仓库
curl -fsSL https://dotfiles.keveon.io/install.sh | sh -s -- --repo <username>

# 使用 SSH 协议
curl -fsSL https://dotfiles.keveon.io/install.sh | sh -s -- --ssh
```

### 强制重装

如果遇到问题或需要重新安装：

```bash
curl -fsSL https://dotfiles.keveon.io/install.sh | sh -s -- --force
```

## 📋 系统要求

### macOS
- macOS 10.15 或更高版本
- Xcode Command Line Tools
- Homebrew（自动安装）

### Linux
- Ubuntu/Debian 或兼容发行版
- apt 包管理器
- sudo 权限

## 🛠️ 包含工具

### 核心工具
- **chezmoi** - Dotfiles 管理工具
- **mise** - 开发环境管理器
- **usage** - CLI 使用帮助

### CLI 工具
- **bat** - 带语法高亮的 cat 替代品
- **eza** - 现代化的 ls 命令
- **fd** - 用户友好的 find 替代品
- **fzf** - 命令行模糊搜索
- **ripgrep (rg)** - 超快的文本搜索
- **starship** - 可定制的 shell 提示符
- **zoxide** - 智能目录跳转
- **lazygit** - Git 的终端 UI
- **htop** - 交互式进程查看器
- **httpie** - 人性化的 HTTP 客户端
- **jq** - JSON 处理工具
- **yq** - YAML 处理工具

### 开发工具
- **docker** - 容器化平台
- **kubectl** - Kubernetes 命令行工具
- **helm** - Kubernetes 包管理器
- **k9s** - Kubernetes 管理工具
- **grpcurl** - gRPC 调试工具
- **neovim** - 现代化的 Vim 编辑器
- **shfmt** - Shell 脚本格式化工具
- **tree-sitter-cli** - 解析器生成工具

### Git 工具
- **gh** - GitHub 官方 CLI
- **krew** - kubectl 插件管理器

### 系统工具
- **tmux** - 终端复用器
- **gnupg** - GNU 隐私卫士
- **pwgen** - 密码生成器

## 🔧 自定义配置

### 修改仓库

```bash
# 使用其他用户的 dotfiles
./install.sh --repo <username>

# 使用完整仓库路径
./install.sh --repo <username>/dotfiles

# 使用自定义域名
./install.sh --repo gitlab.com/<username>/dotfiles
```

### SSH 支持

确保已配置 SSH 密钥并添加到 GitHub：

```bash
# 生成 SSH 密钥
ssh-keygen -t ed25519 -C "your_email@example.com"

# 添加到 GitHub
# 然后使用 SSH 安装
./install.sh --ssh
```

## 📁 配置文件结构

```
.
├── .chezmoidata/
│   └── packages.yaml          # 包管理配置
├── dot_config/
│   ├── mise/
│   │   ├── tasks/            # Mise 任务定义
│   │   └── create_config.local.toml.tmpl  # Mise 配置模板
│   └── ...
├── dot_zprofile.tmpl          # Zsh 配置文件
├── dot_zshenv.tmpl           # Zsh 环境变量
└── install.sh               # 安装脚本
```

## 🎯 常用命令

### Chezmoi 命令

```bash
# 查看配置状态
chezmoi status

# 应用配置
chezmoi apply

# 查看差异
chezmoi diff

# 编辑配置文件
chezmoi edit ~/.zshrc

# 更新到最新版本
chezmoi update

# 添加新文件到配置
chezmoi add ~/.config/nvim/init.vim
```

### Mise 命令

```bash
# 安装所有工具
mise install

# 安装特定工具
mise install node@latest

# 查看已安装工具
mise ls

# 运行特定版本的工具
mise exec node@20 -- node --version
```

## 🔄 更新和维护

### 更新 Dotfiles

```bash
# 拉取最新配置
chezmoi update

# 应用新配置
chezmoi apply

# 重新加载 shell
exec zsh
```

### 备份配置

```bash
# 导出现有配置
chezmoi archive > dotfiles.tar.gz

# 查看配置历史
chezmoi status
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 🙏 致谢

- [Chezmoi](https://www.chezmoi.io/) - 强大的 Dotfiles 管理工具
- [Mise](https://mise.jdx.dev/) - 优秀的开发环境管理器
- [Homebrew](https://brew.sh/) - macOS 包管理器
- 所有开源工具的贡献者们

---

🌟 如果这个项目对你有帮助，请给它一个 Star！
