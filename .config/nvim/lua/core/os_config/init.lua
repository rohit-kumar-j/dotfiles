-- init.lua
local is_win32 = vim.fn.has("win32")
local is_wsl = vim.fn.has("wsl")
local uname = vim.fn.system("uname -s"):gsub("%s+", "") -- trim whitespace/newline

if uname == "Darwin" then
  require("core.os_config.macos")
elseif is_wsl == 1 then
  require("core.os_config.wsl")
elseif is_win32 == 1 then
  require("core.os_config.windows")
elseif uname == "Linux" then
  require("core.os_config.unix")
end

vim.api.nvim_create_user_command("Os", function()
  print("uname: " .. uname)
  print("trash_path: " .. (vim.g.trash_path or "not set"))
  print("workbench notes path: " .. (vim.g.workbench_storage_path or "not set"))
  print("wsl: " .. is_wsl .. " | win32: " .. is_win32)
end, {})
