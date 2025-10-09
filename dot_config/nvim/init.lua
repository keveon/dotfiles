-------------------------------------------------
-- 1. 基础体验
-------------------------------------------------
vim.opt.number         = true   -- 绝对行号
vim.opt.relativenumber = true   -- 相对行号，跳转 3j / 5k 更直观
vim.opt.wrap           = false  -- 长行不折行，水平滚动
vim.opt.scrolloff      = 8      -- 光标离上下边界最少 8 行
vim.opt.signcolumn     = 'yes'  -- 给 git / diagnostic 预留 1 列
vim.opt.mouse          = 'a'    -- 鼠标可用
vim.opt.clipboard      = 'unnamedplus'  -- 与系统剪贴板互通
vim.opt.swapfile       = false  -- 不生成 .swp
vim.opt.undofile       = true   -- 持久化 undo
vim.opt.undodir        = vim.fn.stdpath('data') .. '/undo' -- undo 目录

-------------------------------------------------
-- 2. 搜索
-------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase  = true   -- 有大写字母时区分大小写
vim.opt.hlsearch   = true   -- 搜索结果高亮
vim.keymap.set('n', '<Esc><Esc>', ':nohl<CR>', { silent = true }) -- 连按 Esc 清高亮

-------------------------------------------------
-- 3. Tab & 缩进
-------------------------------------------------
vim.opt.expandtab   = true  -- 用空格代替 Tab
vim.opt.tabstop     = 4     -- 显示宽度
vim.opt.shiftwidth  = 4     -- >> << 时移动列数
vim.opt.smartindent = true  -- C 系智能缩进
vim.opt.fileencoding = 'utf-8'
vim.opt.termguicolors = true  -- 24-bit 颜色

-------------------------------------------------
-- 4. Leader 键 & 常用快捷键
-------------------------------------------------
vim.g.mapleader = ' '          -- 空格作为 Leader
vim.g.maplocalleader = ' '

-- 分屏操作
vim.keymap.set('n', '<leader>sv', '<C-w>v') -- 垂直
vim.keymap.set('n', '<leader>sh', '<C-w>s') -- 水平
vim.keymap.set('n', '<leader>se', '<C-w>=') -- 等宽
vim.keymap.set('n', '<leader>sx', ':close<CR>')

-- 保存 / 退出
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- 快速移动
vim.keymap.set('n', 'J', '5j')  -- 大写 J 下跳 5
vim.keymap.set('n', 'K', '5k')  -- 大写 K 上跳 5
