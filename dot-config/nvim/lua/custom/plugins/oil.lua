return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function ()
    require("oil").setup({ default_file_explorer = true })

    vim.keymap.set('n', '<leader>f', '<CMD>Oil<CR>', { desc = "Open [F]ile explorer" })
  end
}
