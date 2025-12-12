<section
    class="py-20 bg-gradient-to-br from-emerald-50 via-teal-50 to-cyan-100 dark:from-cyan-800 dark:via-teal-800 dark:to-emerald-900"
>
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2
            class="text-3xl font-bold text-center mb-12 text-transparent bg-clip-text bg-gradient-to-r from-emerald-600 to-cyan-600 dark:from-emerald-400 dark:to-cyan-400"
        >
            📦 安装指南
        </h2>
        <div class="grid md:grid-cols-2 gap-8">
            <div
                class="bg-gradient-to-br from-emerald-500 to-teal-600 p-1 rounded-xl shadow-xl"
            >
                <div class="bg-white dark:bg-gray-900 p-6 rounded-lg h-full">
                    <h3
                        class="text-xl font-bold mb-4 text-emerald-600 dark:text-emerald-400"
                    >
                        🚀 快速安装
                    </h3>
                    <p class="text-gray-600 dark:text-gray-300 mb-4">
                        推荐使用一键安装脚本，自动检测操作系统并安装所有依赖：
                    </p>
                    <div class="space-y-4">
                        <div>
                            <p class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">系统要求：</p>
                            <ul class="text-sm text-gray-600 dark:text-gray-400 space-y-1">
                                <li>• macOS 10.15+ 或 Linux (Ubuntu/Debian)</li>
                                <li>• Linux 需要 tmux 依赖</li>
                                <li>• sudo 权限（仅 Linux）</li>
                            </ul>
                        </div>
                        <ol class="list-decimal list-inside space-y-2 text-gray-600 dark:text-gray-300">
                            <li>选择上方安装命令（Curl 或 Wget）</li>
                            <li>复制并粘贴到终端运行</li>
                            <li>等待安装完成，重启终端</li>
                        </ol>
                    </div>
                </div>
            </div>
            <div
                class="bg-gradient-to-br from-cyan-500 to-blue-600 p-1 rounded-xl shadow-xl"
            >
                <div class="bg-white dark:bg-gray-900 p-6 rounded-lg h-full">
                    <h3
                        class="text-xl font-bold mb-4 text-cyan-600 dark:text-cyan-400"
                    >
                        🛠️ 手动安装
                    </h3>
                    <p class="text-gray-600 dark:text-gray-300 mb-4">
                        如需手动安装或了解详细步骤：
                    </p>
                    <div class="space-y-4">
                        <div class="space-y-3">
                            <p class="text-sm font-medium text-gray-700 dark:text-gray-300">安装命令选项：</p>
                            <ul class="text-sm text-gray-600 dark:text-gray-400 space-y-1">
                                <li>• <code class="bg-gray-100 dark:bg-gray-800 px-2 py-0.5 rounded">--repo &lt;username&gt;</code> - 指定仓库</li>
                                <li>• <code class="bg-gray-100 dark:bg-gray-800 px-2 py-0.5 rounded">--ssh</code> - 使用 SSH 协议</li>
                                <li>• <code class="bg-gray-100 dark:bg-gray-800 px-2 py-0.5 rounded">--force</code> - 强制重新安装</li>
                                <li>• <code class="bg-gray-100 dark:bg-gray-800 px-2 py-0.5 rounded">--help</code> - 查看帮助</li>
                            </ul>
                        </div>
                        <ol class="list-decimal list-inside space-y-2 text-gray-600 dark:text-gray-300">
                            <li>
                                安装 Mise: <code
                                    class="bg-gradient-to-r from-emerald-100 to-cyan-100 dark:from-emerald-900 dark:to-cyan-900 px-3 py-1 rounded border border-emerald-300 dark:border-cyan-700"
                                    >curl https://mise.run | sh</code
                                >
                            </li>
                            <li>
                                安装 Chezmoi: <code
                                    class="bg-gradient-to-r from-emerald-100 to-cyan-100 dark:from-emerald-900 dark:to-cyan-900 px-3 py-1 rounded border border-emerald-300 dark:border-cyan-700"
                                    >mise use -g chezmoi</code
                                >
                            </li>
                            <li>
                                初始化配置: <code
                                    class="bg-gradient-to-r from-emerald-100 to-cyan-100 dark:from-emerald-900 dark:to-cyan-900 px-3 py-1 rounded border border-emerald-300 dark:border-cyan-700"
                                    >chezmoi init keveon</code
                                >
                            </li>
                            <li>
                                应用配置: <code
                                    class="bg-gradient-to-r from-emerald-100 to-cyan-100 dark:from-emerald-900 dark:to-cyan-900 px-3 py-1 rounded border border-emerald-300 dark:border-cyan-700"
                                    >chezmoi apply</code
                                >
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
