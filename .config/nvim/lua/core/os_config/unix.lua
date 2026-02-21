-- Unix
--
vim.g.workbench_storage_path = vim.fn.expand("~") .. "/.nvim_workbench/" .. vim.g.notes_folder
local xdg_data = os.getenv("XDG_DATA_HOME") or vim.fn.expand("~/.local/share")
vim.g.trash_path = xdg_data .. "/Trash/files"
