vim.opt.shell="/bin/bash"

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 80
vim.opt.tabstop = 4
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.visualbell = true
vim.opt.ffs = "unix,dos"
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.smartindent = false
vim.opt.colorcolumn = "80"

-- Copy to/paste from system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Don't start comment when creating a new line with 'o' or 'O'
vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:remove("t")

vim.opt.switchbuf:append("useopen,usetab")

vim.opt.splitright = true
vim.opt.showcmd = true

-- Space as leader
vim.g.mapleader=" "
vim.keymap.set("n", "<SPACE>", "<Nop>", {noremap = true})

vim.opt.termguicolors = true

if vim.g.neovide then
  vim.opt.guifont = "FiraCode Nerd Font,Fira Code:h11"
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

require('lazy_boostrap')
require('lazy').setup('plugins')
require('plugins')
require('lsp')

vim.cmd [[
augroup filetype
    au BufNewFile,BufRead *.escript,*.script setf erlang
    au BufNewFile,BufRead justfile setf just
    au FileType javascript setl sts=2 sw=2 ts=2
    au FileType lua setl sts=2 sw=2 ts=2
    au FileType elixir setl sts=2 sw=2 ts=2
    au FileType xml setl sts=2 sw=2 ts=2
augroup end

augroup reloadqueries
    au BufWrite *.scm lua require'nvim-treesitter.query'.invalidate_query_cache()
augroup end
]]

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
