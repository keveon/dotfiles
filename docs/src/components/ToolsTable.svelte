<script>
    // 工具数据
    const toolsData = [
        {
            type: "核心工具",
            macOS: "chezmoi, usage",
            linux: "chezmoi, usage",
        },
        {
            type: "CLI 工具",
            macOS: "-",
            linux: "bat, eza, fd, fzf, rg, starship, zoxide",
        },
        {
            type: "编辑器",
            macOS: "-",
            linux: "neovim",
        },
        {
            type: "开发环境",
            macOS: "通过 Mise 管理",
            linux: "通过 Mise 管理",
        },
        {
            type: "可选工具",
            macOS: "python, cargo:erdtree, cargo:tree-sitter-cli (已注释)",
            linux: "python, cargo:erdtree, cargo:tree-sitter-cli (已注释)",
            colspan: true,
        },
    ];
</script>

<section
    class="py-20 bg-gradient-to-br from-amber-50 via-orange-50 to-yellow-100 dark:from-amber-900 dark:via-orange-900 dark:to-yellow-950"
>
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2
            class="text-3xl font-bold text-center mb-12 text-transparent bg-clip-text bg-gradient-to-r from-amber-600 to-orange-600 dark:from-amber-400 dark:to-orange-400"
        >
            🛠️ 包含工具
        </h2>
        <div
            class="bg-white dark:bg-gray-900 rounded-xl shadow-2xl overflow-hidden border-2 border-amber-200 dark:border-amber-800"
        >
            <table class="w-full">
                <thead
                    class="bg-gradient-to-r from-amber-500 to-orange-500 dark:from-amber-700 dark:to-orange-700"
                >
                    <tr>
                        <th
                            class="px-6 py-4 text-left text-sm font-bold text-white"
                            >类型</th
                        >
                        <th
                            class="px-6 py-4 text-left text-sm font-bold text-white"
                            >macOS</th
                        >
                        <th
                            class="px-6 py-4 text-left text-sm font-bold text-white"
                            >Linux</th
                        >
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                    {#each toolsData as tool, index}
                        <tr class:odd={index % 2 === 1}>
                            <td
                                class="px-6 py-4 font-medium text-gray-900 dark:text-white"
                                >{tool.type}</td
                            >
                            {#if tool.colspan}
                                <td
                                    class="px-6 py-4 text-gray-600 dark:text-gray-300"
                                    colspan="2">{tool.macOS}</td
                                >
                            {:else}
                                <td
                                    class="px-6 py-4 text-gray-600 dark:text-gray-300"
                                    >{tool.macOS}</td
                                >
                                <td
                                    class="px-6 py-4 text-gray-600 dark:text-gray-300"
                                    >{tool.linux}</td
                                >
                            {/if}
                        </tr>
                    {/each}
                </tbody>
            </table>
        </div>
    </div>
</section>
