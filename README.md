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
# 使用 Curl
curl -fsSL https://chezmoi.keveon.io/install.sh | bash

# 使用 Wget
wget -qO- https://chezmoi.keveon.io/install.sh | bash

# 或者克隆仓库后运行
git clone https://github.com/keveon/chezmoi-starter.git
cd chezmoi-starter
./docs/public/install.sh
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
chezmoi init keveon/chezmoi-starter
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
├── .vscode/                        # VSCode 编辑器配置
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
└── docs/                           # 项目文档网站
    └── public/
        └── install.sh              # 网站版安装脚本
```

## 🔧 平台差异配置

系统会根据操作系统自动配置不同的工具集：

### macOS 配置
- **核心工具**: chezmoi, usage
- **开发工具**: 通过 Mise 管理 (Go, Rust, Node.js 等)
- **平台特定**: 通过 Homebrew 管理系统工具

### Linux 配置
- **核心工具**: chezmoi, usage
- **CLI 工具**: bat, eza, fd, fzf, rg, starship, zoxide
- **编辑器**: neovim
- **开发工具**: 通过 Mise 管理 (Go, Rust, Node.js 等)
- **可选工具**: python, cargo:erdtree, cargo:tree-sitter-cli (已注释)
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

### macOS 工具
- **chezmoi**: 配置文件管理
- **usage**: CLI 工具帮助系统

### Linux 工具
- **CLI 工具**: bat, eza, fd, fzf, ripgrep, starship, zoxide
- **编辑器**: neovim
- **核心工具**: chezmoi, usage

### 开发环境 (通过 Mise 管理)
- **Node.js**: LTS 版本
- **Go**: 最新版本，带自动环境配置
- **Rust**: Stable 版本，配置镜像源

### 可选工具 (已注释)
- **Python**: 最新版本
- **Cargo 工具**: erdtree, tree-sitter-cli

## 🔄 常用命令

### Chezmoi 配置管理

#### 基础操作
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

#### 高级功能
```bash
# 查看配置状态
chezmoi status

# 预览将要应用的更改
chezmoi apply --dry-run

# 验证配置文件
chezmoi verify

# 从源码管理器拉取并应用
chezmoi update

# 查看文件在源码库中的实际路径
chezmoi source-path ~/.zshrc

# 查看配置模板渲染结果
chezmoi data          # 显示模板数据
chezmoi execute-template '{{ .chezmoi.os }}'  # 执行模板

# 移除已管理的文件
chezmoi forget ~/.config/nvim/init.lua

# 重新应用所有配置（覆盖本地更改）
chezmoi apply --force
```

#### 多机器管理
```bash
# 查看不同机器的配置差异
chezmoi diff --include=work

# 应用特定机器的配置
chezmoi apply --include=personal

# 查看所有配置模板
chezmoi managed
chezmoi managed --path ~/.zshrc

# 备份当前配置
chezmoi archive --output=chezmoi-backup.tar.gz
```

#### 调试和诊断
```bash
# 详细模式查看操作
chezmoi apply --verbose

# 调试模式
chezmoi --debug apply

# 查看 Chezmoi 版本和配置
chezmoi doctor

# 查看配置文件
chezmoi dump-config
```

### Mise 开发工具管理

#### 基础工具管理
```bash
# 安装所有配置的工具
mise install

# 安装特定工具
mise install node@lts python@3.11

# 列出已安装的工具
mise ls

# 列出可用的工具版本
mise ls-remote node

# 更新工具版本
mise up

# 卸载工具
mise uninstall node@20
```

#### 项目环境管理
```bash
# 查看当前项目配置
mise settings

# 设置项目特定的工具版本
mise use node@18
mise use python@3.10

# 查看项目活跃的工具
mise ls --active

# 在项目目录中自动切换工具版本
cd ~/my-project  # mise 会自动读取 .tool-versions 或 .mise.toml
```

#### 任务系统
```bash
# 查看所有可用任务
mise tasks

# 运行特定任务
mise run go:setup          # 设置 Go 开发环境
mise run rust:setup        # 配置 Rust 环境
mise run pnpm:setup        # 配置 pnpm 包管理器
mise run nvim:setup        # 配置 Neovim

# 运行带参数的任务
mise run dotfiles:sync
mise run dotfiles:sync -- --force   # 强制更新配置
mise run dotfiles:sync -- --status  # 显示同步状态

# 查看任务详情
mise task --list
mise task go:setup
```

#### 高级功能
```bash
# 执行命令在特定工具环境中
mise exec node@18 -- node --version
mise exec python@3.11 -- python --version

# 激活当前 Shell 的 mise 环境
mise activate
mise activate zsh

# 查看 mise 诊断信息
mise doctor

# 清理 mise 缓存
mise clean

# 查看配置文件路径
mise where node@18
mise which python
```

#### 环境变量管理
```bash
# 设置环境变量
mise set EDITOR=nvim
mise set PATH=$HOME/bin:$PATH

# 查看环境变量
mise env
mise env | grep EDITOR

# 在特定环境中运行命令
mise exec --env=production npm run build
```

### Shell 和系统管理

#### Zim 框架管理
```bash
# 更新 Zim 框架
zimfw update

# 升级所有 Zim 模块
zimfw upgrade

# 重新安装 Zim 模块
zimfw install

# 清理 Zim 缓存
zimfw clean

# 查看模块状态
zimfw info
```

#### 系统工具
```bash
# 查看系统信息
neofetch              # 系统信息展示
htop                  # 进程监控
btop                  # 更现代的进程监控 (如果安装)

# 文件管理
eza -la               # 现代化 ls 替代
tree -L 2             # 目录树结构
fd --type f           # 文件搜索
rg "pattern" .        # 文本搜索

# 系统配置
locale                # 查看系统语言环境
timedatectl status    # 查看时区状态 (Linux)
```

#### 开发环境快速设置
```bash
# 一键设置开发环境
mise run go:setup      # Go 环境配置
mise run rust:setup    # Rust 环境配置
mise run pnpm:setup    # pnpm 配置
mise run nvim:setup    # Neovim 配置

# 检查环境状态
mise doctor           # mise 诊断
go version           # Go 版本
rustc --version      # Rust 版本
node --version       # Node.js 版本
```

### 同步和更新
```bash
# 使用 Mise 任务同步配置 (推荐)
mise run dotfiles:sync              # 检查并更新配置
mise run dotfiles:sync -- --force   # 强制更新配置
mise run dotfiles:sync -- --status  # 显示同步状态

# 完整更新流程
chezmoi update          # 拉取最新配置
mise up                 # 更新开发工具
zimfw update           # 更新 Zim 框架
mise run dotfiles:sync  # 同步配置

# 重新运行安装脚本
./docs/public/install.sh
```

## 🌐 项目网站

本项目提供了现代化的文档网站：

- **网址**: https://chezmoi.keveon.io
- **功能**: 在线查看配置说明、一键安装、常用命令参考
- **技术**: Astro + Tailwind CSS，支持深色模式

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License
