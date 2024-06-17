-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Make unwanted invisible characters visible
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions in a separate buffer
vim.opt.inccommand = 'split'

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Keep the cursor 8 lines above the bottom
vim.opt.scrolloff = 8

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { 'menuone', 'noselect' }

vim.opt.termguicolors = true

-- Relative line numbers
vim.opt.relativenumber = true

-- Use nushell by default
vim.opt.shell = 'nu'

-- Don't use swapfiles
vim.opt.swapfile = false

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local function trim_whitespaces()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false);
    for i, line in ipairs(lines) do
        lines[i] = string.gsub(line, "%s+$", "")
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

local remove_trailing_whitespace_group = vim.api.nvim_create_augroup('RmTrWhitespace', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = trim_whitespaces,
  group = remove_trailing_whitespace_group,
  pattern = '*',
})

