# 🏠 个人 Dotfiles 配置

基于 Chezmoi + Mise + Zim 的多平台配置管理方案，支持 macOS 和 Linux。

## ✨ 特性

- 🍎 **macOS** / 🐧 **Linux** 多平台支持
- 🔧 **Chezmoi** 配置文件管理
- 📦 **Mise** 开发工具版本管理
- ⚡ **Zim** Zsh 框架
- 🛠️ **自动化任务**: Go、Rust、Node.js、pnpm、Neovim 等工具配置
- 🌍 **多语言支持**: 中文环境配置

## 🚀 快速开始

### 方法1: 一键安装 (推荐)
```bash
# 下载并运行安装脚本
curl -fsSL https://raw.githubusercontent.com/keveon/dotfiles/main/scripts/install.sh | bash

# 或者克隆仓库后运行
git clone https://github.com/keveon/dotfiles.git
cd dotfiles
./scripts/install.sh
```

### 方法2: 手动安装
#### 1. 安装 Mise
```bash
curl https://mise.run | sh
```

#### 2. 初始化 Chezmoi
```bash
# 安装 chezmoi
mise use -g chezmoi

# 克隆配置
chezmoi init keveon
```

#### 3. 应用配置
```bash
chezmoi apply
```

## 📦 自动安装内容

### 系统依赖
- **macOS**: Homebrew + 基础开发工具 (gpg, tmux, wget, jq, httpie, unzip)
- **Linux**: APT 包管理器 + 常用工具（gpg, tmux, zsh, git, wget, curl, jq, htop, httpie, unzip）

### 开发环境配置
- 默认 Shell 设置为 Zsh
- 系统语言配置为中文 (zh_CN.UTF-8)
- 时区设置为 Asia/Shanghai (Linux)
- Xcode Command Line Tools (macOS)
- Chezmoi 配置管理
- Mise 开发工具版本管理
- Zim Zsh 框架

### 自动化步骤
1. 检测操作系统 (macOS/Linux)
2. 安装系统依赖包
3. 配置默认 Shell
4. 设置语言和时区 (仅 Linux)
5. 安装 Chezmoi 和 Mise
6. 克隆并应用 dotfiles 配置

## 📁 目录结构

```
dotfiles/
├── .chezmoi.toml.tmpl              # Chezmoi 配置模板
├── dot_config/
│   ├── mise/
│   │   ├── config.toml.tmpl        # Mise 工具配置 (平台差异)
│   │   └── tasks/                  # Mise 任务脚本
│   │       ├── dotfiles/           # Dotfiles 同步任务
│   │       ├── go/                 # Go 工具配置
│   │       ├── rust/               # Rust 工具配置
│   │       ├── pnpm/               # pnpm 包管理器配置
│   │       └── nvim/               # Neovim 编辑器配置
│   ├── bat/                        # bat 配置
│   ├── erdtree/                    # erdtree 配置
│   ├── nvim/                       # Neovim 配置
│   │   └── ftdetect/               # 文件类型检测
│   └── chezmoi/
├── dot_zshenv.tmpl                 # Zsh 环境配置
├── dot_zprofile.tmpl               # Zsh 登录配置
├── dot_zshrc.tmpl                  # Zsh 交互配置
├── dot_zimrc                       # Zim 模块配置
└── scripts/                        # 安装脚本
    └── install.sh                  # 一键安装脚本
```

## 🔧 平台差异配置

系统会根据操作系统自动配置不同的工具集：

### macOS 配置
- **核心工具**: chezmoi, node (LTS), pnpm, usage
- **开发工具**: go (带自动配置), rust (stable)
- **平台特定**: 通过 Homebrew 管理系统工具

### Linux 配置
- **核心工具**: chezmoi, node (LTS), pnpm, usage
- **开发工具**: go (带自动配置), rust (stable)
- **额外工具**: bat, eza, fzf, neovim, python, rg, starship, zoxide
- **Cargo 工具**: erdtree, tree-sitter-cli
- **平台特定**: 通过 APT 管理系统工具

### 自动化任务
- **go:setup**: Go 开发环境自动配置
- **rust:setup**: Rust 镜像和工具链配置
- **pnpm:setup**: pnpm 包管理器配置
- **nvim:setup**: Neovim 编辑器配置

## 🌍 语言和时区配置

### 自动化配置
- **系统语言**: 自动设置为 zh_CN.UTF-8
- **时区**: 自动设置为 Asia/Shanghai (仅 Linux)
- **Shell 环境**: 自动配置为 Zsh

### macOS 特定配置
- Xcode Command Line Tools 自动安装
- Apple Silicon 和 Intel Mac 通用支持

### Linux 特定配置
- `locale-gen` 生成中文语言环境
- `localectl` 设置系统默认语言
- `timedatectl` 配置系统时区

## 🔒 权限要求

### macOS
- 普通用户权限即可完成大部分安装
- 设置时区可能需要管理员权限

### Linux
- 大部分操作需要 sudo 权限
- 系统包安装 (apt-get)
- Shell 更改 (chsh)
- 语言环境生成 (locale-gen)
- 时区设置 (timedatectl)
- 系统语言配置 (localectl)

## 🛠️ 包含的工具

### 核心工具 (所有平台)
- **chezmoi**: 配置文件管理
- **zsh**: Shell 环境，配合 Zim 框架
- **mise**: 开发工具版本管理
- **usage**: CLI 工具帮助系统

### 开发环境 (所有平台)
- **Node.js**: LTS 版本，配合 pnpm
- **Go**: 最新版本，带自动环境配置
- **Rust**: Stable 版本，配置镜像源

### 编辑器和 CLI 工具 (仅 Linux)
- **neovim**: 现代化 Vim 编辑器
- **bat**: 语法高亮的 cat 替代品
- **eza**: 现代化的 ls 替代品
- **fd**: 用户友好的 find 替代品
- **ripgrep**: 超快的 grep 替代品
- **fzf**: 命令行模糊查找器
- **starship**: 可定制的 shell 提示符
- **zoxide**: 智能目录跳转工具
- **Python**: 最新版本
- **Cargo 工具**: erdtree, tree-sitter-cli

## 🔄 常用命令

### Chezmoi 基础命令
```bash
# 应用所有配置
chezmoi apply

# 应用特定文件
chezmoi apply ~/.zshrc

# 查看文件差异
chezmoi diff ~/.zshrc

# 编辑源文件
chezmoi edit ~/.zshrc

# 添加新文件
chezmoi add ~/.config/nvim/init.lua

# 更新配置
chezmoi git pull
chezmoi apply
```

### Mise 开发工具管理
```bash
# 安装所有配置的工具
mise install

# 安装特定工具
mise install node@20 python@3.11

# 列出已安装的工具
mise ls

# 更新工具版本
mise up

# 同步 dotfiles 配置
mise run dotfiles:sync              # 检查并更新配置
mise run dotfiles:sync -- --force   # 强制更新配置
mise run dotfiles:sync -- --status  # 显示同步状态
```

### 同步和更新
```bash
# 使用 Mise 任务同步配置 (推荐)
mise run dotfiles:sync              # 检查并更新配置
mise run dotfiles:sync -- --force   # 强制更新配置
mise run dotfiles:sync -- --status  # 显示同步状态

# 重新运行安装脚本
./scripts/install.sh
```

## 🤖 自动同步配置

### 手动同步
```bash
# 检查并更新配置
mise run dotfiles:sync

# 强制更新配置
mise run dotfiles:sync -- --force

# 查看同步状态
mise run dotfiles:sync -- --status
```

### 定期同步建议
为了保持配置的及时更新，建议：

1. **定期手动同步**: 养成定期运行 `mise run dotfiles:sync` 的习惯
2. **版本更新时**: 在更新系统或工具版本后运行同步
3. **设备切换后**: 在不同设备间切换时检查配置同步状态

### 系统集成 (可选)
如需自动化同步，可以根据你的系统设置相应的定时任务：

#### macOS (launchd)
```bash
# 创建 ~/Library/LaunchAgents/com.dotfiles.sync.plist
# 每小时运行一次 mise run dotfiles:sync
```

#### Linux (cron)
```bash
# 添加到 crontab，每小时检查一次
0 * * * * mise run dotfiles:sync >/dev/null 2>&1
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License
