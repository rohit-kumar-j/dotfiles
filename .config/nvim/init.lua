--Globals
local vim = vim
vim.api.nvim_set_var("debug", false)                    -- For debugging o/p
vim.api.nvim_set_var("copy_to_single_clipboard", false) -- Copy with y to main clipboard. Only tested to win32 and wsl
vim.api.nvim_set_var("Is_Asahi", true)                  -- Specific LSP Settings for Aashi Linux ... till it gets fixed

vim.api.nvim_set_var("useDiffViewNvim", true)           -- Diff View
vim.api.nvim_set_var("useGitSigns", true)               -- Side column Git Preview
vim.api.nvim_set_var("useLazyGit", true)                -- Best Git Integration

vim.api.nvim_set_var("useGotoPreview", true)            -- Best Previewer after LSP
vim.api.nvim_set_var("useTrouble", true)                -- Diagnostics in Quickfix list
vim.api.nvim_set_var("useTreesitter", true)             -- Syntax Highlighting
vim.api.nvim_set_var("useHlArgs", false)                -- TODO: Test Highlight Function Args

vim.api.nvim_set_var("useOilNvim", true)                -- For File Buffer
vim.api.nvim_set_var("useLeap", true)                   -- Leaps around code
vim.api.nvim_set_var("useHarpoon", true)                -- File Navigation
vim.api.nvim_set_var("useTelescope", true)              -- GOD Plugin
vim.api.nvim_set_var("useWhichKey", true)               -- Remeber Keys

vim.api.nvim_set_var("useWrapping", true)               -- Line Wrapping Plugin
vim.api.nvim_set_var("useNoice", false)                 -- Commandline and Messages in UI
vim.api.nvim_set_var("useNotify", false)                -- UI Messages

vim.api.nvim_set_var("useMarkdownHeadlines", false)     -- For Markdown Headlines
vim.api.nvim_set_var("useGlowNvim", true)               -- For Markdown Preview
vim.api.nvim_set_var("useVimTableMode", true)           -- For Markdown Tables

vim.api.nvim_set_var("useGodBolt", false)               -- For Compiler Explorer Plugin
vim.api.nvim_set_var("useCodeRunner", false)            -- Code Runner Plugin
vim.api.nvim_set_var("useCMakeTools", true)             -- For Using CMakeTools Plugin
vim.api.nvim_set_var("useCppMan", false)                -- For Cpp Docs Plugin
vim.api.nvim_set_var("useHexEditor", false)             -- Hex Memory Editor
vim.api.nvim_set_var("useGLSLSyntaxHL", false)          -- For Cpp Docs Plugin

vim.api.nvim_set_var("useZenMode", true)                -- Zen Mode
vim.api.nvim_set_var("useTrueZen", true)                -- Multiple Zen Modes
vim.api.nvim_set_var("useTwilight", true)               -- Darker and LIghter Higlights
vim.api.nvim_set_var("useHardtime", false)              -- Disable Spamming HJKL
vim.api.nvim_set_var("useTODOList", true)               -- TODO Lists
vim.api.nvim_set_var("useToggleTerm", true)             -- Terminals

vim.api.nvim_set_var("useLSP", false)                    -- LSP
vim.api.nvim_set_var("useCMP", true)                    -- CMP needs to be on regardless
vim.api.nvim_set_var("useMason", true)                  -- Mason LSP Installer
vim.api.nvim_set_var("useNeogen", true)                 -- Function Annotations

vim.api.nvim_set_var("useLtexLSP", false)               -- Sepcially for latex, keep false
vim.api.nvim_set_var("useStylua", true)                 -- Lus Formatting
vim.api.nvim_set_var("useJupyter", false)               -- Juypter Note Books
vim.api.nvim_set_var("useIncline", false)               -- Floating Status Lines

vim.api.nvim_set_var("useNvimComment", false)           -- Code Commenting
vim.api.nvim_set_var("useCursorAnimations", false)      -- Bad Cursor Animations

vim.api.nvim_set_var("useMiniMap", false)               -- Minimap on the Rightside
vim.api.nvim_set_var("useIndentGuides", true)           -- Indet Rulers
vim.api.nvim_set_var("useUFO", true)                    -- Code Folding

vim.api.nvim_set_var("useWorkBench", true)              -- Pop-up Notes Screen
vim.api.nvim_set_var("useDashboard", false)             -- For Using Dashboard
vim.api.nvim_set_var("useNavbuddy", false)              -- For Using Navbuddy
vim.api.nvim_set_var("useFidgetNvim", false)            -- Fidget Spinner for indexing
vim.api.nvim_set_var("useBufferLineAndNvimTree", false) -- For Using Bufferline and NvimTree Plugin
vim.api.nvim_set_var("useNeoTree", false)               -- Tree View
vim.api.nvim_set_var("useDropbar", false)               -- Breadcrumbs from top of buffer

vim.api.nvim_set_var("useVimspector", true)
vim.api.nvim_set_var("useNvimDAP", false)

-- Quickly load config
vim.loader.enable()

--- Startup Sepcific
vim.g.notes_folder = "nvim_workbench_notes" -- Nvim Workbench

-- Basic Setup
require("core.neovide") -- Neovide Specific Settings
require("core.os_config")
require("core.lsp_settings")
require("core.settings")
require("core.keymaps")

-- Install plugins
require("core.plugins")

------------------------------------

-- final UI commnads
vim.cmd([[:set laststatus=3]]) -- Global Status Line

--- CursorLine Setup
vim.cmd([[:hi CursorLineNr guibg=NONE guifg=#ffffff]]) -- Highlight cursorline
vim.cmd([[:set cursorline]])                           -- Highlight cursorline
vim.cmd([[:set cursorlineopt=number]])                 -- only hihglight the line number

-- Gives vim like feel with NonLine characters
vim.cmd([[:hi EndOfBuffer ctermfg=blue ctermbg=None]])
vim.cmd([[:hi NonText ctermfg=12 guibg=bule]])
vim.cmd([[:hi Search guibg=yellow guifg=green]])
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "lightblue" })
vim.opt.fillchars = { eob = "~" }
