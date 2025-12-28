#!/bin/bash
# 🚀 Chezmoi Dotfiles 快速安装脚本
# 版本: 2.0
# 支持: macOS, Linux (Ubuntu/Debian)

set -euo pipefail

# ============================================================================
# 配置常量
# ============================================================================

readonly SCRIPT_NAME="Dotfiles 安装程序"
readonly REPO_SLUG_DEFAULT="keveon"
readonly CHEZMOI_SOURCE_DIR="$HOME/.local/share/chezmoi"
readonly MISE_INSTALL_DIR="$HOME/.local/bin"

# 颜色输出
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[1;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_RESET='\033[0m'

# ============================================================================
# 工具函数
# ============================================================================

# 日志输出函数
log_info() {
    echo -e "${COLOR_BLUE}ℹ️  $*${COLOR_RESET}"
}

log_success() {
    echo -e "${COLOR_GREEN}✅ $*${COLOR_RESET}"
}

log_warning() {
    echo -e "${COLOR_YELLOW}⚠️  $*${COLOR_RESET}"
}

log_error() {
    echo -e "${COLOR_RED}❌ $*${COLOR_RESET}" >&2
}

# 显示分隔线
show_separator() {
    echo "=================================="
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 等待用户确认
confirm() {
    local message="$1"
    local default="${2:-n}"

    if [[ "$default" == "y" ]]; then
        read -p "$message [Y/n]: " response
        case "${response:-y}" in
            [yY][eE][sS]|[yY]) return 0 ;;
            *) return 1 ;;
        esac
    else
        read -p "$message [y/N]: " response
        case "${response:-n}" in
            [yY][eE][sS]|[yY]) return 0 ;;
            *) return 1 ;;
        esac
    fi
}

# ============================================================================
# 系统检测
# ============================================================================

detect_os() {
    local os=""

    case "$OSTYPE" in
        darwin*)
            os="macos"
            ;;
        linux-gnu*)
            os="linux"
            ;;
        *)
            log_error "不支持的操作系统: $OSTYPE"
            exit 1
            ;;
    esac

    echo "$os"
}

# ============================================================================
# 包管理器安装
# ============================================================================

install_homebrew() {
    if command_exists brew; then
        log_success "Homebrew 已安装"
        return 0
    fi

    log_info "安装 Homebrew..."
    if confirm "是否安装 Homebrew？" "y"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # 添加 Homebrew 到 PATH
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            # Apple Silicon
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            # Intel
            eval "$(/usr/local/bin/brew shellenv)"
        fi

        log_success "Homebrew 安装完成"
    else
        log_error "Homebrew 是必需的包管理器"
        exit 1
    fi
}

install_system_dependencies() {
    local os="$1"

    log_info "安装系统依赖..."

    case "$os" in
        macos)
            install_homebrew
            log_info "通过 Homebrew 安装依赖包..."
            brew install --quiet gpg
            ;;
        linux)
            log_info "通过 apt-get 安装依赖包..."
            sudo apt-get update -y
            sudo apt-get install -y gpg zsh curl git tmux
            ;;
    esac

    log_success "系统依赖安装完成"
}

# ============================================================================
# Mise 和 Chezmoi 安装
# ============================================================================

install_mise() {
    local os="$1"

    if command_exists mise; then
        log_success "Mise 已安装"
        return 0
    fi

    log_info "安装 Mise..."

    case "$os" in
        macos)
            brew install --quiet mise
            ;;
        linux)
            curl https://mise.run | sh
            # 重新加载环境
            export PATH="$MISE_INSTALL_DIR:$PATH"
            if [[ -f "$MISE_INSTALL_DIR/mise" ]]; then
                eval "$("$MISE_INSTALL_DIR/mise" activate bash)"
            fi
            ;;
    esac

    log_success "Mise 安装完成"
}

install_chezmoi() {
    local os="$1"
    local force_reinstall="${2:-false}"

    if command_exists chezmoi && [[ "$force_reinstall" != "true" ]]; then
        log_success "Chezmoi 已安装: $(chezmoi --version)"
        return 0
    fi

    # 如果是强制重装，先卸载现有的 chezmoi
    if [[ "$force_reinstall" == "true" ]] && command_exists chezmoi; then
        log_info "检测到 --force 参数，正在卸载现有的 Chezmoi..."

        case "$os" in
            macos)
                brew uninstall chezmoi 2>/dev/null || true
                ;;
            linux)
                # 通过 Mise 卸载
                if command_exists mise; then
                    mise uninstall chezmoi 2>/dev/null || true
                fi
                # 清理可能的二进制文件
                rm -f "$HOME/.local/bin/chezmoi" 2>/dev/null || true
                ;;
        esac

        log_success "Chezmoi 已卸载"
    fi

    log_info "安装 Chezmoi..."

    case "$os" in
        macos)
            brew install --quiet chezmoi
            ;;
        linux)
            log_info "通过 Mise 安装 Chezmoi..."
            mise use -g chezmoi@latest
            ;;
    esac

    log_success "Chezmoi 安装完成"
}

# ============================================================================
# Shell 配置
# ============================================================================

configure_shell() {
    local os="$1"

    log_info "配置默认 shell 为 zsh..."

    if [[ "$SHELL" != */zsh ]]; then
        case "$os" in
            macos)
                chsh -s /bin/zsh
                ;;
            linux)
                sudo chsh -s /bin/zsh "$USER"
                ;;
        esac
        log_success "默认 shell 已设置为 zsh"
    else
        log_success "默认 shell 已经是 zsh"
    fi
}

# ============================================================================
# 系统配置
# ============================================================================

configure_locale_timezone() {
    local os="$1"

    # macOS 不修改系统语言和时区设置
    if [[ "$os" == "macos" ]]; then
        log_info "macOS 跳过系统语言和时区配置"
        return 0
    fi

    log_info "配置语言和时区..."

    # 生成中文语言环境
    if ! locale -a | grep -q "zh_CN.UTF-8"; then
        if command -v locale-gen >/dev/null 2>&1; then
            sudo locale-gen zh_CN.UTF-8
        else
            log_warning "locale-gen 命令不可用，跳过语言环境生成"
        fi
    fi

    # 设置默认语言
    if command -v localectl >/dev/null 2>&1; then
        if sudo localectl set-locale LANG=zh_CN.UTF-8 2>/dev/null; then
            log_success "系统语言设置为中文"
        else
            log_warning "无法设置系统语言，请手动配置 /etc/default/locale"
        fi
    else
        log_warning "localectl 命令不可用，跳过语言设置"
    fi

    # 设置时区
    if command -v timedatectl >/dev/null 2>&1; then
        if sudo timedatectl set-timezone Asia/Shanghai 2>/dev/null; then
            log_success "时区设置为上海"
        else
            log_warning "无法设置时区，请手动配置 /etc/timezone"
        fi
    else
        log_warning "timedatectl 命令不可用，跳过时区设置"
    fi
}

configure_platform_specific() {
    local os="$1"

    case "$os" in
        macos)
            configure_macos
            ;;
        linux)
            configure_linux
            ;;
    esac
}

configure_macos() {
    log_info "macOS 特定设置..."

    # 检查并安装 Xcode Command Line Tools
    if ! xcode-select -p >/dev/null 2>&1; then
        log_info "安装 Xcode Command Line Tools..."
        xcode-select --install
        log_warning "请等待 Xcode Command Line Tools 安装完成，然后重新运行此脚本"
        exit 1
    else
        log_success "Xcode Command Line Tools 已安装"
    fi

    # 可以在这里添加其他 macOS 特定设置
}

configure_linux() {
    log_info "Linux 特定设置..."

    if command_exists apt; then
        log_success "APT 包管理器可用"
    fi

    # 可以在这里添加其他 Linux 特定设置
}

# ============================================================================
# Chezmoi 配置
# ============================================================================

setup_dotfiles() {
    local force_reinstall=false
    local repo_slug="$REPO_SLUG_DEFAULT"
    local ssh_option=""
    local os
    os=$(detect_os)

    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --repo)
                if [[ $# -lt 2 ]]; then
                    log_error "--repo 需要一个值"
                    show_usage
                    exit 1
                fi
                # 检查下一个参数是否是选项（以--开头）
                if [[ "$2" == --* ]]; then
                    log_error "--repo 的值不能以 -- 开头"
                    echo "请提供有效的仓库名称，例如: keveon 或 keveon/dotfiles"
                    show_usage
                    exit 1
                fi
                repo_slug="$2"
                shift 2
                ;;
            --ssh)
                ssh_option="--ssh"
                shift 1
                ;;
            --force|--reinstall)
                force_reinstall=true
                shift 1
                ;;
            --help|-h)
                show_usage
                exit 0
                ;;
            -*)
                log_error "未知选项: $1"
                show_usage
                exit 1
                ;;
            *)
                log_error "未知参数: $1"
                echo "请使用 --repo $1 来指定仓库"
                show_usage
                exit 1
                ;;
        esac
    done

    # 检查是否已安装
    if [[ -d "$CHEZMOI_SOURCE_DIR" ]] && [[ "$force_reinstall" != "true" ]]; then
        log_info "Dotfiles 已安装，跳过安装步骤"
        echo ""
        echo "💡 如需更新配置，请运行："
        echo "   chezmoi update"
        echo "   chezmoi apply"
        echo ""
        echo "💡 如需强制重新安装，请运行："
        echo "   $0 --force"
        echo ""
        return 0
    fi

    # 如果是强制重装，清理现有配置
    if [[ "$force_reinstall" == "true" ]] && [[ -d "$CHEZMOI_SOURCE_DIR" ]]; then
        log_info "检测到强制重装参数，正在清理现有配置..."
        rm -rf "$CHEZMOI_SOURCE_DIR"
        log_success "现有配置已清理"
    fi

    # 安装 mise
    install_mise "$os"

    # 安装或重装 chezmoi
    install_chezmoi "$os" "$force_reinstall"

    # 克隆并应用 Dotfiles
    log_info "克隆并应用 Dotfiles..."
    case "$os" in
        macos)
            chezmoi init $ssh_option --apply "$repo_slug"
            ;;
        linux)
            mise exec chezmoi -- chezmoi init $ssh_option --apply "$repo_slug"
            ;;
    esac

    log_success "Dotfiles 配置完成"
}

# ============================================================================
# 帮助文档
# ============================================================================

show_usage() {
    cat << EOF
用法: $0 [选项]

选项:
    --repo <REPO>       指定仓库标识符 (默认: $REPO_SLUG_DEFAULT)
                        示例: keveon, keveon/dotfiles, github.com/keveon/dotfiles
    --ssh               使用 SSH 协议（需要配置 SSH 密钥）
    --force, --reinstall 强制重新安装 chezmoi 和 dotfiles
                        会先卸载现有版本，然后重新安装最新版本
    --help, -h          显示帮助信息

示例:
    $0                              # 使用默认仓库 (HTTPS)
    $0 --repo <repo>                # 使用指定用户的仓库 (HTTPS)
    $0 --ssh                        # 使用 SSH 协议克隆默认仓库
    $0 --force                      # 强制重新安装默认仓库
    $0 --repo <repo> --ssh --force  # 组合使用多个选项

重装场景:
    - 当 chezmoi 版本过旧时
    - 当配置文件损坏需要重置时
    - 当切换到不同的 dotfiles 仓库时
    - 当遇到配置冲突需要清理时

注意:
    - 如果 dotfiles 已安装，脚本会跳过安装步骤
    - 使用 --force 会完全重新安装，包括清理现有配置
    - 如需更新配置而不重装，请运行: chezmoi update
    - 使用 --ssh 选项前需要先配置 SSH 密钥
    - 需要添加 SSH 密钥到 GitHub 账户才能正常使用 --ssh

EOF
}

# ============================================================================
# 主函数
# ============================================================================

main() {
    # 显示欢迎信息
    echo "🏠 $SCRIPT_NAME"
    show_separator

    # 检测操作系统
    local os
    os=$(detect_os)

    if [[ "$os" == "macos" ]]; then
        log_success "检测到 macOS"
    else
        log_success "检测到 Linux"
    fi

    # 安装系统依赖
    install_system_dependencies "$os"

    # 配置 Dotfiles（包含参数解析和 chezmoi 安装）
    setup_dotfiles "$@"

    # 配置 Shell
    configure_shell "$os"

    # 配置系统
    configure_locale_timezone "$os"
    configure_platform_specific "$os"

    # 显示完成信息
    show_completion_message
}

show_completion_message() {
    echo ""
    log_success "🎉 安装完成！"
    echo ""
    echo "📝 下一步："
    echo "   1. 重启 shell 或运行: exec zsh"
    echo "   2. 运行: chezmoi status"
    echo "   3. 运行: mise install && exec zsh"
    echo ""
    echo "🔧 常用命令："
    echo "   chezmoi apply            # 应用配置"
    echo "   chezmoi diff             # 查看差异"
    echo "   chezmoi edit ~/<file>    # 编辑文件"
    echo "   chezmoi source <file>    # 查看源文件"
    echo ""
}

# ============================================================================
# 脚本入口
# ============================================================================

# 运行主函数
main "$@"
