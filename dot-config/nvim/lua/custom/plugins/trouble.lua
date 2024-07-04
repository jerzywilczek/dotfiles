-- Diagnostics list for the whole project
return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "toggle [T]rouble (diagnostics)",
    },
    {
      "<leader>ts",
      "<cmd>Trouble symbols toggle focus=true<cr>",
      desc = "toggle [T]rouble ([S]ymbols)",
    },
  }
}

