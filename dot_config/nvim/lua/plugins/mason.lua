return {
  {
    "mason-org/mason.nvim",
    cmd = { "MasonInstallAll" },
    opts = function(_, opts)
      -- Create user command to synchronously install all Mason tools in `opts.ensure_installed`.
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        for _, tool in ipairs(opts.ensure_installed) do
          vim.cmd("MasonInstall " .. tool)
        end
      end, {})

      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }

      -- Override the default ensure_installed list
      opts.ensure_installed = {
        'bash-language-server',
        'rust-analyzer',
        'elp',
        'basedpyright',
        'expert',
        -- 'vimls',
        -- 'yamlls',
      }

      return opts
    end,
  }
}
