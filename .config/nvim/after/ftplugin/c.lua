function Delete_scratch_buffers()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    local name = vim.api.nvim_buf_get_name(buffer)
    if string.match(name, "^scratch_") then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end

local DEBUG = false

local function _debug_print(input)
  if DEBUG then
    print(input)
  end
end

local function cpp_cmd(optimization_level, filename)
  local bin = vim.fn.fnamemodify(filename, ":h") .. "/bin"   -- folder path + \bin
  local fln = vim.fn.fnamemodify(filename, ":t")             -- only filename with extesion
  _debug_print(bin)
  _debug_print("is idr : " .. vim.fn.isdirectory(bin))       -- Test: Check if bin exists

  local cmd = ""
  if DEBUG then
    cmd = ":!cd " .. vim.fn.fnamemodify(filename, ":h") .. " &&"            -- First goto the fodler where main.cpp is loacted
  else
    cmd = ":silent !cd " .. vim.fn.fnamemodify(filename, ":h") .. " &&"     -- First goto the fodler where main.cpp is loacted
  end

  -- Create bin if not exists
  if vim.fn.isdirectory(bin) == 1 then
    cmd = cmd
    _debug_print("found bin")
  else
    cmd = cmd .. " mkdir -p bin &&"
    _debug_print("not found bin")
  end

  cmd = cmd .. " cd bin &&"                                  -- goto bin
  cmd = cmd .. " clang -S -mllvm --x86-asm-syntax=intel -"   -- produce assembly file inside bin
  cmd = cmd .. optimization_level .. " ../" .. fln           -- reference outside filename from within the bin
  _debug_print(cmd)
  vim.cmd(cmd)
end

function AsmOutputUpdate(optimization_level)
  if optimization_level == nil then
    optimization_level = "O0"
  end

  local filename = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
  _debug_print(filename)
  local output_file = vim.fn.fnamemodify(filename, ":t:r") .. ".s"
  _debug_print(output_file)

  cpp_cmd(optimization_level, filename)

  local found = false
  -- Iterate through all open buffers
  for _, winnr in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
    _debug_print(vim.api.nvim_buf_get_name(bufnr))
    -- Check if the buffer's name matches the old assembly file
    if bufname == output_file then
      found = true
      _debug_print("found")
      break
    end
  end
  if not found then
    _debug_print("not found")
    -- Open the <filename>.s file from the bin directory
    vim.cmd(":vs " .. vim.fn.fnamemodify(filename, ":h") .. "/bin/" .. vim.fn.fnamemodify(filename, ":t:r") .. ".s")
    vim.cmd(":wincmd p")
  end
  -- Delete_scratch_buffers()
end

vim.cmd("command! -nargs=+ Asm lua AsmOutputUpdate(<f-args>)")

vim.cmd([[:set nolist]])

vim.o.shiftwidth = 4 -- This so that we do not nest more than thrice
vim.cmd([[set colorcolumn=100]])
-- This sets the '=' indent to 2 spaces instead of 4
vim.cmd([[set tabstop=4]])
vim.cmd([[set shiftwidth=4]])
