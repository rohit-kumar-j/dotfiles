local is_macunix = vim.fn.has("macunix")
local is_win32 = vim.fn.has("win32")
local is_wsl = vim.fn.has("wsl")


if (is_macunix == 1) then
  require("core.os_config.macos")
end
if (is_win32 == 1) then
  require("core.os_config.windows")
end
if (is_wsl == 1) then
  require("core.os_config.wsl")
end
