<script>
  import { onMount } from 'svelte';

  let activeTab = 'curl';
  let copiedCommand = '';

  const commands = {
    curl: "curl -fsSL https://chezmoi.keveon.io/install.sh | bash",
    wget: "wget -qO- https://chezmoi.keveon.io/install.sh | bash"
  };

  const tabs = [
    { id: 'curl', name: '📥 Curl', label: '使用 Curl 安装' },
    { id: 'wget', name: '⬇️ Wget', label: '使用 Wget 安装' }
  ];

  function switchTab(tabId) {
    activeTab = tabId;
  }

  async function copyCommand(command) {
    try {
      await navigator.clipboard.writeText(commands[command]);
      copiedCommand = command;

      // 2秒后重置状态
      setTimeout(() => {
        copiedCommand = '';
      }, 2000);
    } catch (err) {
      console.error("复制失败:", err);
    }
  }

  $: currentCommand = commands[activeTab];
  $: currentTabInfo = tabs.find(tab => tab.id === activeTab);
</script>

<div class="bg-white dark:bg-gray-800 rounded-xl shadow-lg p-8 max-w-2xl mx-auto">
  <h2 class="text-2xl font-bold mb-6 text-gray-900 dark:text-white">
    🚀 一键安装
  </h2>

  <!-- Tab 切换 -->
  <div class="relative bg-gray-100 dark:bg-gray-700 rounded-lg p-1 mb-6">
    <div class="flex">
      {#each tabs as tab}
        <button
          id="tab-{tab.id}"
          class="tab-btn flex-1 relative z-10 px-4 py-2 text-sm font-medium rounded-md transition-all duration-200 {
            activeTab === tab.id
              ? 'bg-white dark:bg-gray-600 text-primary-600 dark:text-primary-400 shadow-sm'
              : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100'
          }"
          on:click={() => switchTab(tab.id)}
          data-tab={tab.id}
        >
          <span class="flex items-center justify-center">
            {tab.name}
          </span>
        </button>
      {/each}
    </div>
  </div>

  <!-- 命令显示区域 -->
  <div class="command-container">
    <div class="flex items-center justify-between mb-2">
      <label class="text-sm font-medium text-gray-700 dark:text-gray-300">
        {currentTabInfo?.label}
      </label>
      <button
        class="copy-btn text-sm px-3 py-1 rounded-md transition-colors {
          copiedCommand === activeTab
            ? 'bg-green-600 hover:bg-green-700 text-white'
            : 'bg-primary-600 hover:bg-primary-700 text-white'
        }"
        on:click={() => copyCommand(activeTab)}
        data-command={activeTab}
      >
        {copiedCommand === activeTab ? '✅ 已复制' : '📋 复制'}
      </button>
    </div>
    <div class="bg-gray-100 dark:bg-gray-900 p-4 rounded-lg font-mono text-sm break-all">
      {currentCommand}
    </div>
  </div>
</div>
