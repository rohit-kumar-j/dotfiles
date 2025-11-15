return {
  "CRAG666/code_runner.nvim",
  enabled = vim.api.nvim_get_var("useCodeRunner"),
  event = "BufReadPre",
  config = function()
    local code_runner = require("code_runner")

    code_runner.setup({
      mode = "term",
      startinsert = true,
      filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        python = "python3 -u",
        typescript = "deno run",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        c = "cd $dir && mkdir -p bin && cd bin && clang ../$fileName -o $fileName.exe && ./$fileName.exe",
        cpp = "cd $dir && mkdir -p bin && cd bin && clang++ ../$fileName -o $fileName.exe && ./$fileName.exe",
        -- cpp = "cd $dir && mkdir -p bin && cd bin && gcc -fsyntax-only ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
      },
      project = {}
    })
  end
}
