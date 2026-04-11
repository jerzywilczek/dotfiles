local M = {}

---@class PluginSpecTable
--- string in the form: 'gh:user/plugin' or 'cb:user/plugin'
---@field [1] string
--- the branch/commit to pull
---@field version? string
--- options, passed to configure or to the autodetected main module setup function
--- note: autodetection for now picks the chars after the last '/' and removes '.nvim'
--- if neither configure nor opts are not set, no configuration code is run
---@field opts? table
--- a function called to configure the plugin
--- if neither configure nor opts are not set, no configuration code is run
---@field configure? fun(opts: table)
--- higher priority = earlier configure
---@field priority? number

---@alias PluginSpec PluginSpecTable | string

---@param plugins_dir string
---@return PluginSpecTable[]
local function gather_specs(plugins_dir)
  local specs = {}
  local full_path = vim.fn.stdpath('config') .. '/lua/' .. plugins_dir

  local handle, err = vim.uv.fs_scandir(full_path)
  if not handle then
    vim.print('Error while importing plugin specs: ' .. err)
    return specs
  end

  while true do
    local name, filetype = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end

    if filetype == 'file' and name:match('%.lua$') then
      local module_name = name:gsub('%.lua$', '')
      local module_path = plugins_dir:gsub('/', '.') .. '.' .. module_name
      local status, sourced_spec = pcall(function()
        return require(module_path)
      end)
      if not status then
        local error = sourced_spec
        vim.print("Error while trying to import spec from '" .. module_path .. "': " .. error)
        goto continue
      end

      local function add_spec(spec)
        if type(spec) == 'table' then
          table.insert(specs, spec)
        else
          table.insert(specs, { spec })
        end
      end

      if type(sourced_spec) == 'table' then
        if table.maxn(sourced_spec) > 1 then
          for _, plugin in ipairs(sourced_spec) do
            add_spec(plugin)
          end
        else
          add_spec(sourced_spec)
        end
      end
    end
    ::continue::
  end

  return specs
end

--- This is a very simple API for specifying plugins in separate files, inspired by `lazy.nvim`.
---
--- Basically, you feed the path to the directory where you want to define plugins into this method.
--- Then, each .lua file in this directory will be sourced automatically. Each file should return a
--- `PluginSpec` (class defined in this file) or a list of `PluiginSpec`s:
--- ```lua
--- return {
---   'gh:user/plugin',
--- }
--- ```
--- The class definition documents all fields.
---
--- All sourced plugin specs will then be fed to `vim.pack.add`, and after that their respective
--- config methods will be called.
---
---@param plugins_dir string
function M.setup(plugins_dir)
  local specs = gather_specs(plugins_dir)

  table.sort(specs, function(a, b)
    return (a.priority or 0) > (b.priority or 0)
  end)

  local pack_specs = vim.tbl_map(function(spec)
    local src = spec[1]:gsub('^gh:', 'https://github.com/'):gsub('^cb:', 'https://codeberg.org/')
    return { src = src, version = spec.version }
  end, specs)
  vim.pack.add(pack_specs)

  for _, spec in ipairs(specs) do
    if not spec.opts and not spec.configure then
      goto continue
    end

    local opts = spec.opts or {}

    if spec.configure then
      local status, error = pcall(spec.configure, opts)
      if not status then
        vim.print("Error in user 'configure' function for plugin '" .. spec[1] .. "':\n" .. error)
      end
    else
      local split_name = vim.split(spec[1], '/')
      local main_module = split_name[table.maxn(split_name)]:gsub('%.nvim', '')
      local status, error = pcall(function()
        require(main_module).setup(opts)
      end)

      if not status then
        vim.print("Error in autodetected setup function for plugin '" ..
        spec[1] .. "' - 'require(" .. main_module .. ").setup':\n" .. error)
      end
    end

    ::continue::
  end
end

return M
