-- WSL
--
-- Multi/Single clipboard copy
if (vim.api.nvim_get_var("copy_to_single_clipboard") == true) then
  vim.cmd [[
	augroup Yank
	autocmd!
	autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
	augroup END
	]]
end
vim.g.workbench_storage_path = vim.fn.expand("~") .. "/.cache/nvim_workbench/" .. vim.g.notes_folder
