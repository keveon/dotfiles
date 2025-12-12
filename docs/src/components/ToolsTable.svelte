<script>
    // 工具数据 - 与 packages.yaml 保持同步
    const toolsData = [
        {
            type: "📁 文件管理",
            icon: "📂",
            color: "from-blue-500 to-cyan-500",
            tools: [
                { name: "eza", desc: "现代化 ls 替代品，支持图标、Git 集成和彩色输出", macOS: true, linux: true },
                { name: "fd", desc: "用户友好的 find 替代品，语法简洁，速度快", macOS: true, linux: true },
                { name: "tree", desc: "以树形结构显示目录层次", macOS: true, linux: true },
                { name: "erdtree", desc: "现代化的多线程文件树查看器，支持文件大小统计", macOS: true, linux: false },
                { name: "watch", desc: "监控文件变化并执行命令", macOS: true, linux: false },
            ]
        },
        {
            type: "🔍 文本搜索与查看",
            icon: "🔎",
            color: "from-purple-500 to-pink-500",
            tools: [
                { name: "bat", desc: "带语法高亮的 cat，支持 Git 集成和文件预览", macOS: true, linux: true },
                { name: "ripgrep", desc: "超快的文本搜索工具 (rg)，支持正则表达式", macOS: true, linux: true },
                { name: "fzf", desc: "命令行模糊搜索器，交互式选择界面", macOS: true, linux: true },
            ]
        },
        {
            type: "⚡ 效率工具",
            icon: "⚡",
            color: "from-amber-500 to-orange-500",
            tools: [
                { name: "zoxide", desc: "智能目录跳转工具，基于访问频率和最近使用", macOS: true, linux: true },
                { name: "lazygit", desc: "Git 的终端 UI，可视化 Git 操作", macOS: true, linux: true },
                { name: "htop", desc: "交互式进程查看器，资源监控利器", macOS: true, linux: true },
                { name: "httpie", desc: "人性化的 HTTP 客户端，语法简洁友好", macOS: true, linux: false },
            ]
        },
        {
            type: "🛠️ 开发工具",
            icon: "👨‍💻",
            color: "from-emerald-500 to-teal-500",
            tools: [
                { name: "neovim", desc: "现代化的 Vim 编辑器，支持 Lua 和 LSP", macOS: true, linux: true },
                { name: "shfmt", desc: "Shell 脚本格式化工具，统一代码风格", macOS: true, linux: true },
                { name: "biome", desc: "高性能前端工具链，代码格式化和 Lint", macOS: true, linux: false },
                { name: "tree-sitter-cli", desc: "解析器生成工具，支持多种编程语言", macOS: true, linux: true },
            ]
        },
        {
            type: "🐳 容器与云原生",
            icon: "🐋",
            color: "from-sky-500 to-blue-600",
            tools: [
                { name: "docker", desc: "容器化平台，应用打包和部署", macOS: true, linux: true },
                { name: "podman", desc: "无守护进程的容器引擎，Docker 替代品", macOS: true, linux: false },
                { name: "kubectl", desc: "Kubernetes 命令行工具，集群管理", macOS: true, linux: true },
                { name: "helm", desc: "Kubernetes 包管理器，应用部署模板化", macOS: true, linux: true },
                { name: "k9s", desc: "Kubernetes 管理工具，可视化操作界面", macOS: true, linux: true },
                { name: "kustomize", desc: "Kubernetes 配置管理，无模板定制", macOS: true, linux: false },
                { name: "grpcurl", desc: "gRPC 调试工具，与 gRPC 服务器交互", macOS: true, linux: true },
            ]
        },
        {
            type: "🔧 数据处理",
            icon: "🔨",
            color: "from-violet-500 to-purple-600",
            tools: [
                { name: "jq", desc: "JSON 处理和查询工具，支持过滤和转换", macOS: true, linux: true },
                { name: "yq", desc: "YAML 处理工具，类似 jq 的 YAML 版本", macOS: true, linux: true },
                { name: "nali", desc: "IP 地址归属地查询工具", macOS: true, linux: false },
                { name: "wget", desc: "文件下载工具，支持 HTTP/HTTPS/FTP", macOS: true, linux: true },
            ]
        },
        {
            type: "📝 Git 与版本控制",
            icon: "🔀",
            color: "from-slate-600 to-zinc-700",
            tools: [
                { name: "gh", desc: "GitHub 官方 CLI，管理 Issues、PR 等", macOS: true, linux: true },
                { name: "krew", desc: "kubectl 插件管理器，扩展 kubectl 功能", macOS: true, linux: false },
            ]
        },
        {
            type: "🎨 终端美化",
            icon: "🎨",
            color: "from-pink-500 to-rose-500",
            tools: [
                { name: "starship", desc: "可定制的 Shell 提示符，支持多种语言", macOS: true, linux: true },
            ]
        },
        {
            type: "🔐 安全工具",
            icon: "🔑",
            color: "from-red-500 to-rose-600",
            tools: [
                { name: "gnupg", desc: "GNU 隐私卫士 (GPG)，加密和签名", macOS: true, linux: true },
                { name: "pwgen", desc: "密码生成器，生成安全随机密码", macOS: true, linux: false },
            ]
        },
        {
            type: "⚙️ 系统工具",
            icon: "⚙️",
            color: "from-neutral-500 to-stone-600",
            tools: [
                { name: "tmux", desc: "终端复用器，多窗口会话管理", macOS: true, linux: true },
                { name: "telnet", desc: "远程登录工具，测试网络连接", macOS: true, linux: false },
                { name: "unzip", desc: "ZIP 解压工具", macOS: true, linux: false },
                { name: "ca-certificates", desc: "CA 证书，HTTPS 连接信任", macOS: true, linux: false },
                { name: "coreutils", desc: "GNU 核心工具集，基础命令增强", macOS: true, linux: false },
            ]
        },
    ];

    // 计算统计数据
    const allTools = toolsData.flatMap(cat => cat.tools);
    const totalTools = allTools.length;
    const linuxTools = allTools.filter(t => t.linux).length;
    const linuxPercent = Math.round((linuxTools / totalTools) * 100);
</script>

<section
    class="py-20 bg-gradient-to-br from-gray-50 via-white to-slate-100 dark:from-gray-900 dark:via-gray-800 dark:to-slate-900"
>
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-8">
            <h2
                class="text-3xl font-bold text-center mb-4 text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-600 dark:from-indigo-400 dark:to-purple-400"
            >
                🛠️ 包含工具
            </h2>
            <p class="text-lg text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
                精选现代化开发工具，涵盖文件管理、文本搜索、开发效率等各个方面
            </p>
        </div>

        <!-- 统计信息 - 放在顶部作为概览 -->
        <div class="mb-12 grid grid-cols-3 gap-4 md:gap-6">
            <div class="bg-white dark:bg-gray-800 rounded-xl p-6 text-center shadow-md border border-gray-200 dark:border-gray-700">
                <div class="text-4xl md:text-5xl font-bold text-indigo-600 dark:text-indigo-400">{totalTools}</div>
                <div class="text-sm text-gray-600 dark:text-gray-400 mt-2 font-medium">精选工具</div>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-xl p-6 text-center shadow-md border border-gray-200 dark:border-gray-700">
                <div class="text-4xl md:text-5xl font-bold text-emerald-600 dark:text-emerald-400">100%</div>
                <div class="text-sm text-gray-600 dark:text-gray-400 mt-2 font-medium">macOS 兼容</div>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-xl p-6 text-center shadow-md border border-gray-200 dark:border-gray-700">
                <div class="text-4xl md:text-5xl font-bold text-sky-600 dark:text-sky-400">{linuxPercent}%</div>
                <div class="text-sm text-gray-600 dark:text-gray-400 mt-2 font-medium">Linux 兼容</div>
            </div>
        </div>

        <!-- 工具卡片网格 -->
        <div class="grid gap-6 md:gap-8">
            {#each toolsData as category}
                <div class="group">
                    <!-- 分类标题 -->
                    <div class="flex items-center mb-6">
                        <span class="text-3xl mr-3">{category.icon}</span>
                        <h3 class="text-2xl font-bold bg-gradient-to-r {category.color} bg-clip-text text-transparent">
                            {category.type}
                        </h3>
                    </div>

                    <!-- 工具卡片 -->
                    <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                        {#each category.tools as tool}
                            <div
                                class="bg-white/80 dark:bg-gray-800/40 backdrop-blur-sm rounded-xl p-5 shadow-md hover:shadow-lg transition-all duration-300 border border-gray-200/60 dark:border-gray-700/40 hover:border-indigo-300/60 dark:hover:border-indigo-500/40 group"
                            >
                                <!-- 工具名称和平台支持 -->
                                <div class="flex items-start justify-between mb-3">
                                    <h4 class="text-lg font-semibold text-gray-800 dark:text-gray-50 font-mono group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">
                                        {tool.name}
                                    </h4>
                                    <div class="flex gap-2">
                                        {#if tool.macOS}
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-50 text-emerald-600 dark:bg-emerald-900/20 dark:text-emerald-300 border border-emerald-200 dark:border-emerald-800/30"
                                                title="支持 macOS"
                                            >
                                                macOS
                                            </span>
                                        {/if}
                                        {#if tool.linux}
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-sky-50 text-sky-600 dark:bg-sky-900/20 dark:text-sky-300 border border-sky-200 dark:border-sky-800/30"
                                                title="支持 Linux"
                                            >
                                                Linux
                                            </span>
                                        {/if}
                                    </div>
                                </div>

                                <!-- 工具描述 -->
                                <p class="text-sm text-gray-600 dark:text-gray-300 leading-relaxed">
                                    {tool.desc}
                                </p>
                            </div>
                        {/each}
                    </div>
                </div>
            {/each}
        </div>
    </div>
</section>

<style>
    /* 确保网格布局在移动端也能正常显示 */
    @media (max-width: 768px) {
        .grid {
            grid-template-columns: 1fr;
        }
    }
</style>