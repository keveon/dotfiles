<script>
    import { onMount } from "svelte";

    // 主题模式
    const THEMES = {
        LIGHT: "light",
        DARK: "dark",
        AUTO: "auto",
    };

    let currentTheme = THEMES.AUTO;
    let icons = {
        light: null,
        dark: null,
        auto: null,
    };

    // 获取当前主题
    function getCurrentTheme() {
        const saved = localStorage.getItem("theme");
        return saved || THEMES.AUTO;
    }

    // 设置主题
    function setTheme(theme) {
        localStorage.setItem("theme", theme);
        currentTheme = theme;
        applyTheme(theme);
        updateIcons(theme);
        updateTooltip(theme);
    }

    // 应用主题到页面
    function applyTheme(theme) {
        const html = document.documentElement;
        if (theme === THEMES.LIGHT) {
            html.classList.remove("dark");
        } else if (theme === THEMES.DARK) {
            html.classList.add("dark");
        } else if (theme === THEMES.AUTO) {
            // 自动模式：跟随系统主题
            if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
                html.classList.add("dark");
            } else {
                html.classList.remove("dark");
            }
        }
    }

    // 更新图标显示
    function updateIcons(theme) {
        // 隐藏所有图标
        Object.values(icons).forEach((icon) => {
            if (icon) icon.classList.add("hidden");
        });

        // 显示当前主题对应的图标
        if (theme === THEMES.LIGHT) {
            icons.light?.classList.remove("hidden");
        } else if (theme === THEMES.DARK) {
            icons.dark?.classList.remove("hidden");
        } else if (theme === THEMES.AUTO) {
            icons.auto?.classList.remove("hidden");
        }
    }

    // 更新按钮提示文字
    function updateTooltip(theme) {
        const tooltips = {
            [THEMES.LIGHT]: "亮色模式",
            [THEMES.DARK]: "暗色模式",
            [THEMES.AUTO]: "自动模式 (跟随系统)",
        };

        const button = document.getElementById("theme-toggle");
        if (button) {
            button.title = tooltips[theme] || "自动模式";
        }
    }

    // 切换主题
    function toggleTheme() {
        let nextTheme;

        // 循环切换：auto -> light -> dark -> auto
        if (currentTheme === THEMES.AUTO) {
            nextTheme = THEMES.LIGHT;
        } else if (currentTheme === THEMES.LIGHT) {
            nextTheme = THEMES.DARK;
        } else {
            nextTheme = THEMES.AUTO;
        }

        setTheme(nextTheme);
    }

    // 监听系统主题变化
    function watchSystemTheme() {
        const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");

        mediaQuery.addEventListener("change", () => {
            // 只有在自动模式下才响应系统主题变化
            if (currentTheme === THEMES.AUTO) {
                applyTheme(THEMES.AUTO);
            }
        });
    }

    // 初始化主题
    function initTheme() {
        const theme = getCurrentTheme();
        currentTheme = theme;
        applyTheme(theme);

        // 等待 DOM 更新后再获取图标元素
        setTimeout(() => {
            icons = {
                light: document.getElementById("icon-light"),
                dark: document.getElementById("icon-dark"),
                auto: document.getElementById("icon-auto"),
            };
            updateIcons(theme);
            updateTooltip(theme);
        }, 0);

        watchSystemTheme();
    }

    onMount(() => {
        initTheme();
    });
</script>

<button
    id="theme-toggle"
    class="p-2 text-gray-600 dark:text-gray-400 hover:text-primary-600 dark:hover:text-primary-400 transition-colors"
    title="切换主题"
    on:click={toggleTheme}
>
    <!-- 太阳图标 (亮色模式) -->
    <svg
        id="icon-light"
        class="w-5 h-5 theme-icon hidden"
        fill="currentColor"
        viewBox="0 0 20 20"
    >
        <path
            d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z"
        ></path>
    </svg>
    <!-- 月亮图标 (暗色模式) -->
    <svg
        id="icon-dark"
        class="w-5 h-5 theme-icon hidden"
        fill="currentColor"
        viewBox="0 0 20 20"
    >
        <path
            d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"
        ></path>
    </svg>
    <!-- 自动图标 (跟随系统) -->
    <svg
        id="icon-auto"
        class="w-5 h-5 theme-icon"
        fill="currentColor"
        viewBox="0 0 24 24"
    >
        <!-- 太阳和月亮组合图标表示自动切换 -->
        <path
            d="M12 18c-3.31 0-6-2.69-6-6s2.69-6 6-6 6 2.69 6 6-2.69 6-6 6zm0-10c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4z"
        />
        <path
            d="M12 3c.41 0 .75-.34.75-.75S12.41 1.5 12 1.5s-.75.34-.75.75S11.59 3 12 3z"
        />
        <path
            d="M12 21c.41 0 .75.34.75.75s-.34.75-.75.75-.75-.34-.75-.75.34-.75.75-.75z"
        />
        <path
            d="M21 12c0 .41.34.75.75.75s.75-.34.75-.75-.34-.75-.75-.75-.75.34-.75.75z"
        />
        <path
            d="M3 12c0 .41.34.75.75.75s.75-.34.75-.75-.34-.75-.75-.75-.75.34-.75.75z"
        />
        <path
            d="M18.36 5.64c.29-.29.29-.77 0-1.06s-.77-.29-1.06 0-.29.77 0 1.06.77.29 1.06 0z"
        />
        <path
            d="M6.7 17.3c.29-.29.29-.77 0-1.06s-.77-.29-1.06 0-.29.77 0 1.06.77.29 1.06 0z"
        />
        <path
            d="M18.36 18.36c.29.29.77.29 1.06 0s.29-.77 0-1.06-.77-.29-1.06 0-.29.77 0 1.06z"
        />
        <path
            d="M5.64 6.7c.29.29.77.29 1.06 0s.29-.77 0-1.06-.77-.29-1.06 0-.29.77 0 1.06z"
        />
    </svg>
</button>
