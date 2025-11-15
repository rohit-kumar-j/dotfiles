-- MACOS
--
-- Multi/Single clipboard copy
if (vim.api.nvim_get_var("copy_to_single_clipboard") == true) then
  vim.opt.clipboard:prepend { "unnamedplus" }
end

vim.g.workbench_storage_path = vim.fn.expand("~") .. "/.cache/nvim_workbench/" .. vim.g.notes_folder
