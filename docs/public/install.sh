#!/bin/bash
# 🚀 快速安装脚本 - Chezmoi Dotfiles

set -e

echo "🏠 Keveon's Dotfiles 安装程序"
echo "=================================="

GITHUB_USERNAME=keveon

# 检测操作系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo "🍎 检测到 macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo "🐧 检测到 Linux"
else
    echo "❌ 不支持的操作系统: $OSTYPE"
    exit 1
fi

# 安装系统依赖
echo "📦 安装系统依赖..."
if [[ "$OS" == "macos" ]]; then
    # macOS 使用 Homebrew
    if command -v brew >/dev/null 2>&1; then
        echo "✅ Homebrew 已安装"
    else
        echo "📦 安装 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # 添加 Homebrew 到 PATH
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            # Apple Silicon
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            # Intel
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    echo "📦 通过 Homebrew 安装依赖包..."
    brew install gpg tmux wget jq httpie unzip

else
    # Linux 使用 apt-get
    echo "📦 通过 apt-get 安装依赖包..."
    sudo apt-get update -y
    sudo apt-get install -y gpg tmux zsh git wget curl jq htop httpie unzip
fi

# 检查是否已安装 chezmoi
if command -v chezmoi >/dev/null 2>&1; then
    echo "✅ Chezmoi 已安装: $(chezmoi --version)"
else
    echo "📦 安装 Chezmoi..."

    # 检查是否已安装 mise
    if command -v mise >/dev/null 2>&1; then
        echo "✅ 通过 Mise 安装 Chezmoi..."
        mise use -g chezmoi@latest
    else
        echo "📦 先安装 Mise..."
        curl https://mise.run | sh

        # 重新加载环境
        export PATH="$HOME/.local/bin:$PATH"
        if [[ -f "$HOME/.local/bin/mise" ]]; then
            eval "$("$HOME/.local/bin/mise" activate bash)"
        fi

        echo "✅ 通过 Mise 安装 Chezmoi..."
        mise use -g chezmoi@latest
    fi
fi

# 检查并应用 dotfiles
if [[ -d "$HOME/.local/share/chezmoi" ]]; then
    echo "📁 Dotfiles 已存在，更新中..."
    chezmoi update
else
    echo "📥 克隆并应用 Dotfiles..."
    mise exec chezmoi -- chezmoi init --apply --force ${GITHUB_USERNAME:-keveon}/${REPO_NAME:-chezmoi-starter}
fi

# 配置默认 shell
echo "🐚 配置默认 shell 为 zsh..."
if [[ "$SHELL" != */zsh ]]; then
    if [[ "$OS" == "macos" ]]; then
        # macOS 使用 chsh
        chsh -s /bin/zsh
    else
        # Linux 使用 chsh
        sudo chsh -s /bin/zsh $USER
    fi
    echo "✅ 默认 shell 已设置为 zsh"
else
    echo "✅ 默认 shell 已经是 zsh"
fi

# 配置语言和时区
echo "🌍 配置语言和时区..."
if [[ "$OS" != "macos" ]]; then
    # Linux 语言和时区设置
    echo "🐧 Linux 语言和时区设置..."

    # 生成中文语言环境
    if ! locale -a | grep -q "zh_CN.UTF-8"; then
        sudo locale-gen zh_CN.UTF-8
    fi

    # 设置默认语言
    sudo localectl set-locale LANG=zh_CN.UTF-8 2>/dev/null || {
        echo "⚠️  无法设置系统语言，请手动配置 /etc/default/locale"
    }

    # 设置时区
    sudo timedatectl set-timezone Asia/Shanghai 2>/dev/null || {
        echo "⚠️  无法设置时区，请手动配置 /etc/timezone"
    }
fi

# 平台特定的额外设置
if [[ "$OS" == "macos" ]]; then
    echo "🍎 macOS 特定设置..."

    # 检查并安装 Xcode Command Line Tools
    if ! xcode-select -p >/dev/null 2>&1; then
        echo "📦 安装 Xcode Command Line Tools..."
        xcode-select --install
        echo "⚠️  请等待 Xcode Command Line Tools 安装完成，然后重新运行此脚本"
        exit 1
    else
        echo "✅ Xcode Command Line Tools 已安装"
    fi

    # 启用允许任何来源的应用（可选）
    # sudo spctl --master-disable

else
    echo "🐧 Linux 特定设置..."

    # 检查是否有其他包管理器冲突
    if command -v apt >/dev/null 2>&1; then
        echo "✅ APT 包管理器可用"
    fi
fi

echo ""
echo "🎉 安装完成！"
echo ""
echo "📝 下一步："
echo "   1. 编辑本地配置: vim $LOCAL_ENV_FILE"
echo "   2. 重启 shell 或运行: source ~/.zshrc"
echo "   3. 运行: chezmoi status"
echo "   4. 运行: mise install && exec zsh"
echo ""
echo "🔧 常用命令："
echo "   chezmoi apply    # 应用配置"
echo "   chezmoi diff     # 查看差异"
echo "   chezmoi edit ~/<file>  # 编辑文件"
echo ""
