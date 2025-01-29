return {
  {
    "williamboman/mason.nvim",
    cmd = { "MasonInstallAll" },
    opts = function(_, opts)
      -- Create user command to synchronously install all Mason tools in `opts.ensure_installed`.
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        for _, tool in ipairs(opts.ensure_installed) do
          vim.cmd("MasonInstall " .. tool)
        end
      end, {})

      return opts
    end,
  },
}
