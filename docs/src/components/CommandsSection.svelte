<script>
    import { onMount } from "svelte";

    // 所有命令的映射
    const commands = {
        "chezmoi apply": "chezmoi apply",
        "chezmoi status": "chezmoi status",
        "chezmoi apply --dry-run": "chezmoi apply --dry-run",
        "chezmoi update": "chezmoi update",
        "chezmoi archive --output=backup.tar.gz":
            "chezmoi archive --output=backup.tar.gz",
        "mise install": "mise install",
        "mise ls-remote node": "mise ls-remote node",
        "mise exec node@18 -- node --version":
            "mise exec node@18 -- node --version",
        "mise tasks": "mise tasks",
        "mise run go:setup": "mise run go:setup",
        "mise run rust:setup": "mise run rust:setup",
        "mise use node@18": "mise use node@18",
        "mise set EDITOR=nvim": "mise set EDITOR=nvim",
        "mise doctor": "mise doctor",
        "mise run dotfiles:sync": "mise run dotfiles:sync",
        "zimfw update": "zimfw update",
        "mise up": "mise up",
    };

    // 复制功能
    async function copyCommand(command, event) {
        const text = commands[command];
        if (!text) return;

        try {
            await navigator.clipboard.writeText(text);

            const button = event?.currentTarget;
            if (!button) return;

            // 更新按钮文本和样式
            const originalText = button.textContent;
            button.textContent = "✅";
            button.classList.add("bg-green-600", "hover:bg-green-700");
            button.classList.remove(
                "bg-gray-600",
                "hover:bg-gray-700",
                "bg-blue-600",
                "hover:bg-blue-700",
                "bg-purple-600",
                "hover:bg-purple-700",
            );

            // 2秒后恢复原状
            setTimeout(() => {
                if (button) {
                    button.textContent = "📋";

                    // 根据按钮类型恢复对应颜色
                    if (
                        button.classList.contains("bg-blue-600") ||
                        button.classList.contains("bg-green-600") ||
                        button.classList.contains("bg-purple-600")
                    ) {
                        // 保留原有颜色类
                        button.classList.remove(
                            "bg-green-600",
                            "hover:bg-green-700",
                        );
                    } else {
                        // 默认灰色
                        button.classList.add(
                            "bg-gray-600",
                            "hover:bg-gray-700",
                        );
                        button.classList.remove(
                            "bg-green-600",
                            "hover:bg-green-700",
                        );
                    }
                }
            }, 2000);
        } catch (err) {
            console.error("复制失败:", err);
        }
    }
</script>

<section
    class="py-20 bg-gradient-to-br from-violet-50 via-purple-50 to-indigo-100 dark:from-violet-900 dark:via-purple-900 dark:to-indigo-950"
>
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2
            class="text-3xl font-bold text-center mb-12 text-transparent bg-clip-text bg-gradient-to-r from-violet-600 to-indigo-600 dark:from-violet-400 dark:to-indigo-400"
        >
            🔧 常用命令
        </h2>

        <!-- Mise 高级功能展示 -->
        <div class="mb-16">
            <div class="text-center mb-8">
                <h3
                    class="text-2xl font-bold text-primary-600 dark:text-primary-400 mb-4"
                >
                    ⚡ Mise - 强大的开发环境管理器
                </h3>
                <p class="text-gray-600 dark:text-gray-300 max-w-3xl mx-auto">
                    Mise
                    不仅仅是版本管理器，它还提供任务自动化、环境变量管理、项目级配置等强大功能
                </p>
            </div>

            <div class="grid md:grid-cols-3 gap-6 mb-8">
                <div
                    class="bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-900 dark:to-blue-800 p-6 rounded-lg"
                >
                    <h4
                        class="font-bold text-lg mb-3 text-blue-900 dark:text-blue-100"
                    >
                        🔧 工具管理
                    </h4>
                    <div class="space-y-3">
                        <div class="bg-white dark:bg-blue-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise install</code
                                >
                                <button
                                    class="text-xs bg-blue-600 hover:bg-blue-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise install", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                安装所有配置工具
                            </p>
                        </div>
                        <div class="bg-white dark:bg-blue-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise ls-remote node</code
                                >
                                <button
                                    class="text-xs bg-blue-600 hover:bg-blue-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise ls-remote node", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                查看可用版本
                            </p>
                        </div>
                        <div class="bg-white dark:bg-blue-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise exec node@18 -- node --version</code
                                >
                                <button
                                    class="text-xs bg-blue-600 hover:bg-blue-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand(
                                            "mise exec node@18 -- node --version",
                                            e,
                                        )}>📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                特定版本执行
                            </p>
                        </div>
                    </div>
                </div>

                <div
                    class="bg-gradient-to-br from-green-50 to-green-100 dark:from-green-900 dark:to-green-800 p-6 rounded-lg"
                >
                    <h4
                        class="font-bold text-lg mb-3 text-green-900 dark:text-green-100"
                    >
                        🚀 任务系统
                    </h4>
                    <div class="space-y-3">
                        <div class="bg-white dark:bg-green-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs">mise tasks</code
                                >
                                <button
                                    class="text-xs bg-green-600 hover:bg-green-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise tasks", e)}>📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                查看所有任务
                            </p>
                        </div>
                        <div class="bg-white dark:bg-green-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise run go:setup</code
                                >
                                <button
                                    class="text-xs bg-green-600 hover:bg-green-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise run go:setup", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                Go 环境配置
                            </p>
                        </div>
                        <div class="bg-white dark:bg-green-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise run rust:setup</code
                                >
                                <button
                                    class="text-xs bg-green-600 hover:bg-green-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise run rust:setup", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                Rust 环境配置
                            </p>
                        </div>
                    </div>
                </div>

                <div
                    class="bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-900 dark:to-purple-800 p-6 rounded-lg"
                >
                    <h4
                        class="font-bold text-lg mb-3 text-purple-900 dark:text-purple-100"
                    >
                        🌍 环境管理
                    </h4>
                    <div class="space-y-3">
                        <div class="bg-white dark:bg-purple-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise use node@18</code
                                >
                                <button
                                    class="text-xs bg-purple-600 hover:bg-purple-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise use node@18", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                项目级工具设置
                            </p>
                        </div>
                        <div class="bg-white dark:bg-purple-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise set EDITOR=nvim</code
                                >
                                <button
                                    class="text-xs bg-purple-600 hover:bg-purple-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise set EDITOR=nvim", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                环境变量设置
                            </p>
                        </div>
                        <div class="bg-white dark:bg-purple-900 p-3 rounded">
                            <div class="flex justify-between items-center mb-1">
                                <code class="font-mono text-xs"
                                    >mise doctor</code
                                >
                                <button
                                    class="text-xs bg-purple-600 hover:bg-purple-700 text-white px-2 py-1 rounded transition-colors"
                                    on:click={(e) =>
                                        copyCommand("mise doctor", e)}
                                    >📋</button
                                >
                            </div>
                            <p class="text-xs text-gray-600 dark:text-gray-400">
                                系统诊断
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid md:grid-cols-2 gap-8">
            <div>
                <h3
                    class="text-xl font-bold mb-6 text-primary-600 dark:text-primary-400"
                >
                    🏠 Chezmoi 配置管理
                </h3>
                <div class="space-y-4">
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm">chezmoi apply</code>
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) =>
                                    copyCommand("chezmoi apply", e)}>📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            应用所有配置文件
                        </p>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm">chezmoi status</code
                            >
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) =>
                                    copyCommand("chezmoi status", e)}>📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            查看配置状态
                        </p>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm"
                                >chezmoi apply --dry-run</code
                            >
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) =>
                                    copyCommand("chezmoi apply --dry-run", e)}
                                >📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            预览将要应用的更改
                        </p>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm">chezmoi update</code
                            >
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) =>
                                    copyCommand("chezmoi update", e)}>📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            拉取并应用最新配置
                        </p>
                    </div>
                </div>
            </div>
            <div>
                <h3
                    class="text-xl font-bold mb-6 text-primary-600 dark:text-primary-400"
                >
                    🔄 同步与维护
                </h3>
                <div class="space-y-4">
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm"
                                >mise run dotfiles:sync</code
                            >
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) =>
                                    copyCommand("mise run dotfiles:sync", e)}
                                >📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            同步 dotfiles 配置
                        </p>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm">zimfw update</code>
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) => copyCommand("zimfw update", e)}
                                >📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            更新 Zim 框架
                        </p>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm">mise up</code>
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) => copyCommand("mise up", e)}
                                >📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            更新开发工具版本
                        </p>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-2">
                            <code class="font-mono text-sm"
                                >chezmoi archive --output=backup.tar.gz</code
                            >
                            <button
                                class="text-xs bg-gray-600 hover:bg-gray-700 text-white px-2 py-1 rounded transition-colors"
                                on:click={(e) =>
                                    copyCommand(
                                        "chezmoi archive --output=backup.tar.gz",
                                        e,
                                    )}>📋</button
                            >
                        </div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            备份当前配置
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
