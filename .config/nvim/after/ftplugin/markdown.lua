--       " Vim syntax file
--       " Add checkboxes to *.md files
--       " source: https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
function _G.pcall_markdown_sugar()
  vim.cmd([[
    augroup markdown
      autocmd!
      au BufEnter *.md :syn match todoCheckbox '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
      au BufEnter *.md :syn match todoCheckbox '\v(\s+)?(-|\*)\s\[x\]'hs=e-4 conceal cchar=
      au BufEnter *.md :syn match todoCheckbox '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=󰅘
      au BufEnter *.md :syn match todoCheckbox '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
      au BufEnter *.md :syn match todoCheckbox '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕
      :hi def link todoCheckbox Todo
      :highlight Conceal guibg=NONE guifg=#5A9E70
    augroup END
    :setlocal conceallevel=1
    :setlocal concealcursor=v
  ]])
end

pcall_markdown_sugar()
