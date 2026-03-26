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

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Rounded window borders
vim.o.winborder = 'rounded'

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local function trim_whitespaces()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    lines[i] = string.gsub(line, '%s+$', '')
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

local remove_trailing_whitespace_group = vim.api.nvim_create_augroup('RmTrWhitespace', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = trim_whitespaces,
  group = remove_trailing_whitespace_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

if vim.env.ZELLIJ then
  os.execute 'zellij action switch-mode locked'
end

-- Overwrite a single option for a running LSP client by server name.
-- Usage: lsp_set("lua_ls", "settings.Lua.diagnostics.globals", { "vim" })
local function lsp_set(server_name, dotpath, value)
  for _, client in ipairs(vim.lsp.get_clients({ name = server_name })) do
    local keys = vim.split(dotpath, ".", { plain = true })
    local tbl = client.config
    for i = 1, #keys - 1 do
      tbl[keys[i]] = tbl[keys[i]] or {}
      tbl = tbl[keys[i]]
    end
    tbl[keys[#keys]] = value
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
end

vim.api.nvim_create_user_command("LspSet", function(opts)
  local server, dotpath, raw_value = opts.fargs[1], opts.fargs[2], table.concat(opts.fargs, " ", 3)
  local ok, value = pcall(loadstring("return " .. raw_value))
  if not ok then value = raw_value end
  lsp_set(server, dotpath, value)
  vim.notify(server .. ": " .. dotpath .. " updated")
end, {
  nargs = "+",
  desc = "Overwrite a single LSP option for this session",
  complete = function(arg_lead, cmdline, _)
    local args = vim.split(cmdline, "%s+", { trimempty = true })
    -- account for trailing space (user is starting next arg)
    local nargs = #args - 1 -- subtract command name
    if cmdline:match("%s$") then nargs = nargs + 1 end

    -- arg 1: server name from active clients
    if nargs <= 1 then
      local names = {}
      for _, c in ipairs(vim.lsp.get_clients()) do
        if vim.startswith(c.name, arg_lead) then
          names[c.name] = true
        end
      end
      return vim.tbl_keys(names)
    end

    -- arg 2: dot-path into that server's config
    if nargs == 2 then
      local server_name = args[2]
      local clients = vim.lsp.get_clients({ name = server_name })
      if #clients == 0 then return {} end

      local function collect_paths(tbl, prefix)
        local paths = {}
        if type(tbl) ~= "table" then return paths end
        for k, v in pairs(tbl) do
          local full = prefix ~= "" and (prefix .. "." .. k) or k
          table.insert(paths, full)
          if type(v) == "table" and not vim.islist(v) then
            vim.list_extend(paths, collect_paths(v, full))
          end
        end
        return paths
      end

      local all = collect_paths(clients[1].config, "")
      return vim.tbl_filter(function(p) return vim.startswith(p, arg_lead) end, all)
    end

    -- arg 3: current value as a hint
    if nargs == 3 then
      local server_name, dotpath = args[2], args[3]
      local clients = vim.lsp.get_clients({ name = server_name })
      if #clients == 0 then return {} end

      local val = clients[1].config
      for _, key in ipairs(vim.split(dotpath, ".", { plain = true })) do
        if type(val) ~= "table" then break end
        val = val[key]
      end

      if val ~= nil then
        return { vim.inspect(val, { newline = " ", indent = "" }) }
      end
    end

    return {}
  end,
})
