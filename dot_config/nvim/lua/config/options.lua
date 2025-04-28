-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 80
vim.opt.tabstop = 4
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.visualbell = true
vim.opt.ffs = "unix,dos"
vim.opt.mouse = "a"
vim.opt.colorcolumn = "80"

vim.opt.foldenable = false

if vim.g.neovide then
  vim.opt.guifont = "FiraCode Nerd Font,Fira Code:h11"
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

-- Don't start comment when creating a new line with 'o' or 'O'
vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:remove("t")

vim.opt.switchbuf:append("useopen,usetab")
vim.opt.splitright = true

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.autoformat = false
vim.g.ai_cmp = false
