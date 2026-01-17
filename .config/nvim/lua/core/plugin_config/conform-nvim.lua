-- In your conform.nvim config
return {
	"stevearc/conform.nvim",
	enabled = true,
	event = { "BufWritePre" },
	keys = {
		{
			"f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" }, function(err)
					if not err then
						local mode = vim.api.nvim_get_mode().mode
						if vim.startswith(string.lower(mode), "v") then
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
						end
					end
				end)
			end,
			mode = "v",
			desc = "Format selected range",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
		notify_no_formatters = true,
		-- Customize formatters
		formatters = {
			stylua = {
				prepend_args = {
					"--indent-type",
					"Spaces",
					"--indent-width",
					"2",
					"--column-width",
					"120",
					"--quote-style",
					"AutoPreferDouble",
				},
			},
		},
	},
}

--- old working config
-- return {
--   "stevearc/conform.nvim",
--   enabled = true, --vim.api.nvim_get_var("useLSP"),
--   event = "InsertEnter",
--   opts = {
--     -- Fix: should be formatters_by_ft, not format_by_ft
--     formatters_by_ft = {
--       lua = { "stylua" },
--       python = { "isort", "black" },
--     },
--     -- Remove format_on_save from here since you're handling it manually
--     log_level = vim.log.levels.ERROR,
--     notify_on_error = true,
--     notify_no_formatters = true,
--   },
-- }
