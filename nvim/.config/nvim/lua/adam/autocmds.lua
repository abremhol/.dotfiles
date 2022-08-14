local api = vim.api
-- toggle relative in insert

local toggleRelativeGroup = api.nvim_create_augroup("ToggleRelativeInInsert", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	command = "lua vim.opt.relativenumber = true",
	group = toggleRelativeGroup,
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	command = "lua vim.opt.relativenumber = false",
	group = toggleRelativeGroup,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

ATTACH_TO_BUFFER = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("BuildDotnetGroup", { clear = true }),
		pattern = pattern,
		callback = function()
			local append_data = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end
			local commandstr = table.concat(command, " ")
			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output of: " .. commandstr })
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stderr = append_data,
			})
		end,
	})
end

local bufnr = FIND_BUFFER_BY_NAME("/tmp/netbuild")
if bufnr == nil or bufnr == "" then
	vim.cmd("vnew /tmp/netbuild")
	bufnr = FIND_BUFFER_BY_NAME("/tmp/netbuild")
end
ATTACH_TO_BUFFER(bufnr, "*.cs", {"dotnet", "build", "-v", "q"})
