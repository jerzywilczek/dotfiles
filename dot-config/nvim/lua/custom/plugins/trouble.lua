-- Diagnostics list for the whole project
return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "toggle [T]rouble (diagnostics)",
    },
  }
}

