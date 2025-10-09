-- Chezmoi 模板文件类型检测
-- 根据扩展名和文件名模式自动识别文件类型

-- 统一处理所有 chezmoi 相关文件
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '*.tmpl', 'dot_*' },
    callback = function()
        local filename = vim.fn.expand('%:t')
        local filetype = nil

        -- 处理 *.tmpl 文件
        if filename:match('%.tmpl$') then
            -- 先尝试匹配 dot_ 前缀的特殊文件
            if filename:match('^dot_zshrc%.tmpl$') then
                filetype = 'zsh'
            elseif filename:match('^dot_bashrc%.tmpl$') then
                filetype = 'bash'
            elseif filename:match('^dot_%.+%.tmpl$') then
                -- 其他 dot_*.tmpl 格式，直接提取名称作为文件类型
                local name = filename:match('^dot_(.+)%.tmpl$')
                if name then
                    -- 常见文件类型映射
                    if name == 'zsh' or name == 'bash' or name == 'sh' then
                        filetype = name
                    elseif name == 'vim' or name == 'vi' then
                        filetype = 'vim'
                    elseif name == 'lua' then
                        filetype = 'lua'
                    elseif name == 'py' or name == 'python' then
                        filetype = 'python'
                    elseif name == 'js' or name == 'javascript' then
                        filetype = 'javascript'
                    elseif name == 'ts' or name == 'typescript' then
                        filetype = 'typescript'
                    else
                        -- 直接使用名称作为文件类型
                        filetype = name
                    end
                end
            else
                -- 尝试从扩展名提取文件类型 (如 config.toml.tmpl -> toml)
                local ext = filename:match('^.+%.(.+)%.tmpl$')
                if ext then
                    filetype = ext
                end
            end
        end

        -- 处理没有 .tmpl 的 dot_ 文件
        if not filetype and filename:match('^dot_') then
            if filename:match('^dot_%.zshrc$') or filename:match('^dot_%.zsh$') then
                filetype = 'zsh'
            elseif filename:match('^dot_%.bashrc$') or filename:match('^dot_%.bash$') then
                filetype = 'bash'
            elseif filename:match('^dot_%.sh$') then
                filetype = 'sh'
            elseif filename:match('^dot_%.vim$') or filename:match('^dot_%.vi$') then
                filetype = 'vim'
            elseif filename:match('^dot_%.lua$') then
                filetype = 'lua'
            elseif filename:match('^dot_%.py$') or filename:match('^dot_%.python$') then
                filetype = 'python'
            elseif filename:match('^dot_%.js$') or filename:match('^dot_%.javascript$') then
                filetype = 'javascript'
            elseif filename:match('^dot_%.ts$') or filename:match('^dot_%.typescript$') then
                filetype = 'typescript'
            end
        end

        -- 如果检测到了文件类型，则设置
        if filetype then
            vim.bo.filetype = filetype
        end
    end,
})

-- 环境变量文件
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '.env*', '*.env' },
    callback = function()
        vim.bo.filetype = 'sh'
    end,
})

-- Chezmoi 配置文件
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { 'chezmoi.*', '*chezmoi*.toml' },
    callback = function()
        vim.bo.filetype = 'toml'
    end,
})
