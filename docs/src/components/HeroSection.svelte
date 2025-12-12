<script>
    import { onMount } from "svelte";

    let activeTab = "curl";
    let useSSH = false;
    let forceReinstall = false;
    let copyButton = null;
    let copyButtonText = "📋 复制";
    let originalCopyButtonText = "📋 复制";

    const commands = {
        curl: "curl -fsSL https://dotfiles.keveon.io/install.sh | bash",
        curl_ssh:
            "curl -fsSL https://dotfiles.keveon.io/install.sh | bash -s -- --ssh",
        curl_force:
            "curl -fsSL https://dotfiles.keveon.io/install.sh | bash -s -- --force",
        curl_ssh_force:
            "curl -fsSL https://dotfiles.keveon.io/install.sh | bash -s -- --ssh --force",
        wget: "wget -qO- https://dotfiles.keveon.io/install.sh | bash",
        wget_ssh:
            "wget -qO- https://dotfiles.keveon.io/install.sh | bash -s -- --ssh",
        wget_force:
            "wget -qO- https://dotfiles.keveon.io/install.sh | bash -s -- --force",
        wget_ssh_force:
            "wget -qO- https://dotfiles.keveon.io/install.sh | bash -s -- --ssh --force",
    };

    // 切换标签页
    function switchTab(tabName) {
        activeTab = tabName;
    }

    // 获取当前命令
    function getCurrentCommand() {
        let commandKey = activeTab;

        if (useSSH && forceReinstall) {
            commandKey = `${activeTab}_ssh_force`;
        } else if (useSSH) {
            commandKey = `${activeTab}_ssh`;
        } else if (forceReinstall) {
            commandKey = `${activeTab}_force`;
        }

        return commands[commandKey];
    }

    // 复制命令
    async function copyCommand() {
        try {
            const currentCommand = getCurrentCommand();
            await navigator.clipboard.writeText(currentCommand);

            // 更新按钮文本和样式
            originalCopyButtonText = copyButtonText;
            copyButtonText = "✅ 已复制";

            // 添加绿色背景
            if (copyButton) {
                copyButton.classList.add("bg-green-600", "hover:bg-green-700");
                copyButton.classList.remove(
                    "bg-primary-600",
                    "hover:bg-primary-700",
                );
            }

            // 2秒后恢复原状
            setTimeout(() => {
                copyButtonText = originalCopyButtonText;
                if (copyButton) {
                    copyButton.classList.remove(
                        "bg-green-600",
                        "hover:bg-green-700",
                    );
                    copyButton.classList.add(
                        "bg-primary-600",
                        "hover:bg-primary-700",
                    );
                }
            }, 2000);
        } catch (err) {
            console.error("复制失败:", err);
        }
    }

    onMount(() => {
        // 初始化复制按钮引用
        copyButton = document.querySelector('[data-command="install"]');
    });
</script>

<section
    class="bg-gradient-to-br from-sky-50 via-blue-50 to-cyan-100 dark:from-slate-800 dark:via-gray-800 dark:to-neutral-900 py-20"
>
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h1
            class="text-4xl md:text-6xl font-bold text-gray-800 dark:text-gray-100 mb-6 drop-shadow-lg"
        >
            <span class="text-5xl md:text-7xl drop-shadow-lg animate-pulse"
                >🏠</span
            >
            <br />
            个人 Dotfiles 配置
        </h1>
        <p
            class="text-xl md:text-2xl text-gray-700 dark:text-gray-300 mb-8 max-w-3xl mx-auto drop-shadow-lg"
        >
            基于 Chezmoi + Mise 的多平台配置管理方案，一键安装 30+ 精选开发工具，支持 macOS 和 Linux
        </p>

        <!-- 一键安装区域 -->
        <div
            class="bg-white/90 dark:bg-gray-900/90 backdrop-blur-lg rounded-2xl shadow-2xl p-8 max-w-2xl mx-auto border border-white/20 ring-2 ring-purple-500/20"
        >
            <h2
                class="text-2xl font-bold mb-6 bg-gradient-to-r from-indigo-500 to-purple-500 dark:from-indigo-300 dark:to-purple-300 bg-clip-text text-transparent"
            >
                🚀 一键安装
            </h2>

            <!-- Tab 切换 -->
            <div
                class="relative bg-gradient-to-r from-gray-50 to-gray-100 dark:from-gray-800 dark:to-gray-700 rounded-lg p-1 mb-6 border border-purple-200 dark:border-purple-700"
            >
                <div class="flex">
                    <button
                        class="tab-btn flex-1 relative z-10 px-4 py-2 text-sm font-medium rounded-md transition-all duration-200 {activeTab ===
                        'curl'
                            ? 'bg-white dark:bg-gray-600 text-primary-600 dark:text-primary-400 shadow-sm'
                            : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100'}"
                        on:click={() => switchTab("curl")}
                    >
                        <span class="flex items-center justify-center">
                            📥 Curl
                        </span>
                    </button>
                    <button
                        class="tab-btn flex-1 relative z-10 px-4 py-2 text-sm font-medium rounded-md transition-all duration-200 {activeTab ===
                        'wget'
                            ? 'bg-white dark:bg-gray-600 text-primary-600 dark:text-primary-400 shadow-sm'
                            : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100'}"
                        on:click={() => switchTab("wget")}
                    >
                        <span class="flex items-center justify-center">
                            ⬇️ Wget
                        </span>
                    </button>
                </div>
            </div>

            <!-- SSH 选项 -->
            <div class="mb-4">
                <label class="flex items-center cursor-pointer group">
                    <input
                        type="checkbox"
                        bind:checked={useSSH}
                        class="w-4 h-4 text-primary-600 bg-gray-100 border-gray-300 rounded focus:ring-primary-500 dark:focus:ring-primary-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600 cursor-pointer accent-primary-600"
                    />
                    <span
                        class="ml-3 text-sm font-medium text-gray-700 dark:text-gray-300 group-hover:text-primary-600 dark:group-hover:text-primary-400 transition-colors"
                    >
                        🔐 使用 SSH 协议（需要配置 SSH 密钥）
                    </span>
                </label>
                {#if useSSH}
                    <p
                        class="mt-2 text-xs text-gray-600 dark:text-gray-400 ml-7"
                    >
                        🔑 需要提前配置 SSH 密钥并添加到 GitHub 账户
                    </p>
                {/if}
            </div>

            <!-- 强制重装选项 -->
            <div class="mb-6">
                <label class="flex items-center cursor-pointer group">
                    <input
                        type="checkbox"
                        bind:checked={forceReinstall}
                        class="w-4 h-4 text-primary-600 bg-gray-100 border-gray-300 rounded focus:ring-primary-500 dark:focus:ring-primary-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600 cursor-pointer accent-primary-600"
                    />
                    <span
                        class="ml-3 text-sm font-medium text-gray-700 dark:text-gray-300 group-hover:text-orange-600 dark:group-hover:text-orange-400 transition-colors"
                    >
                        ⚡ 强制重新安装（清理现有配置）
                    </span>
                </label>
                {#if forceReinstall}
                    <p
                        class="mt-2 text-xs text-gray-600 dark:text-gray-400 ml-7"
                    >
                        ⚠️ 将删除现有的 chezmoi 配置并重新安装
                    </p>
                {/if}
            </div>

            <!-- 命令显示区域 -->
            <div class="command-container">
                <div class="command-content">
                    <div
                        class="bg-gray-100 dark:bg-gray-900 p-4 rounded-lg font-mono text-sm text-left break-all flex items-center justify-between"
                    >
                        <span class="flex-1">{getCurrentCommand()}</span>
                        <button
                            bind:this={copyButton}
                            data-command="install"
                            class="text-sm bg-primary-600 hover:bg-primary-700 text-white px-3 py-1 rounded-md transition-colors ml-4 flex-shrink-0"
                            on:click={copyCommand}
                        >
                            {copyButtonText}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
