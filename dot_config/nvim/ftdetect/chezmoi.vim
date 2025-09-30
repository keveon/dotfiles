" Chezmoi 模板文件类型检测
" 根据扩展名和文件名模式自动识别文件类型

" 清除 *.tmpl 的默认文件类型
autocmd BufRead,BufNewFile *.tmpl set filetype=

" 根据 .tmpl 前的扩展名设置文件类型
autocmd BufRead,BufNewFile *.toml.tmpl set filetype=toml
autocmd BufRead,BufNewFile *.yaml.tmpl,*.yml.tmpl set filetype=yaml
autocmd BufRead,BufNewFile *.json.tmpl set filetype=json
autocmd BufRead,BufNewFile *.sh.tmpl set filetype=sh
autocmd BufRead,BufNewFile *.zsh.tmpl set filetype=zsh
autocmd BufRead,BufNewFile *.bash.tmpl set filetype=bash
autocmd BufRead,BufNewFile *.vim.tmpl,*.vi.tmpl set filetype=vim
autocmd BufRead,BufNewFile *.lua.tmpl set filetype=lua
autocmd BufRead,BufNewFile *.py.tmpl,*.python.tmpl set filetype=python
autocmd BufRead,BufNewFile *.js.tmpl,*.javascript.tmpl set filetype=javascript
autocmd BufRead,BufNewFile *.ts.tmpl,*.typescript.tmpl set filetype=typescript
autocmd BufRead,BufNewFile *.rs.tmpl,*.rust.tmpl set filetype=rust
autocmd BufRead,BufNewFile *.go.tmpl set filetype=go
autocmd BufRead,BufNewFile *.java.tmpl set filetype=java
autocmd BufRead,BufNewFile *.php.tmpl set filetype=php
autocmd BufRead,BufNewFile *.rb.tmpl,*.ruby.tmpl set filetype=ruby
autocmd BufRead,BufNewFile *.css.tmpl set filetype=css
autocmd BufRead,BufNewFile *.scss.tmpl,*.sass.tmpl set filetype=scss
autocmd BufRead,BufNewFile *.html.tmpl set filetype=html
autocmd BufRead,BufNewFile *.xml.tmpl set filetype=xml
autocmd BufRead,BufNewFile *.md.tmpl,*.markdown.tmpl set filetype=markdown

" Chezmoi 特殊文件名处理 (dot_ 前缀)
autocmd BufRead,BufNewFile dot_*.zsh set filetype=zsh
autocmd BufRead,BufNewFile dot_*.sh set filetype=sh
autocmd BufRead,BufNewFile dot_*.bash set filetype=bash
autocmd BufRead,BufNewFile dot_*.vim, dot_*.vi set filetype=vim
autocmd BufRead,BufNewFile dot_*.lua set filetype=lua
autocmd BufRead,BufNewFile dot_*.py, dot_*.python set filetype=python
autocmd BufRead,BufNewFile dot_*.js, dot_*.javascript set filetype=javascript
autocmd BufRead,BufNewFile dot_*.ts, dot_*.typescript set filetype=typescript
autocmd BufRead,BufNewFile dot_*.rs, dot_*.rust set filetype=rust
autocmd BufRead,BufNewFile dot_*.go set filetype=go
autocmd BufRead,BufNewFile dot_*.java set filetype=java
autocmd BufRead,BufNewFile dot_*.php set filetype=php
autocmd BufRead,BufNewFile dot_*.rb, dot_*.ruby set filetype=ruby
autocmd BufRead,BufNewFile dot_*.css set filetype=css
autocmd BufRead,BufNewFile dot_*.scss, dot_*.sass set filetype=scss
autocmd BufRead,BufNewFile dot_*.html set filetype=html
autocmd BufRead,BufNewFile dot_*.xml set filetype=xml
autocmd BufRead,BufNewFile dot_*.md, dot_*.markdown set filetype=markdown
autocmd BufRead,BufNewFile dot_*.json set filetype=json
autocmd BufRead,BufNewFile dot_*.yaml, dot_*.yml set filetype=yaml
autocmd BufRead,BufNewFile dot_*.toml set filetype=toml

" 环境变量文件
autocmd BufRead,BufNewFile .env*,*.env set filetype=sh

" Chezmoi 配置文件
autocmd BufRead,BufNewFile chezmoi.* set filetype=toml
autocmd BufRead,BufNewFile *chezmoi*.toml set filetype=toml
