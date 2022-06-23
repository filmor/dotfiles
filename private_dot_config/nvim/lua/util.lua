return {
  set_keymap = function(scope, from, to)
    vim.api.nvim_set_keymap(scope, from, to, {silent = true, noremap = true})
  end
}
