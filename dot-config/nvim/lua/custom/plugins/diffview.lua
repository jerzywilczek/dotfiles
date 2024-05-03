return {
  'sindrets/diffview.nvim',
  config = function ()
    vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<CR>", { desc = "Open Diff[V]iew" })
    vim.keymap.set("n", "<leader>gV", "<cmd>DiffviewClose<CR>", { desc = "Close Diff[V]iew" })
  end
}
