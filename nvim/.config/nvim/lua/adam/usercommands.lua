vim.api.nvim_create_user_command("AutoRun", function()
	local pattern = vim.fn.input("Pattern: ")
	local command = vim.split(vim.fn.input("Command: "), " ")
	local bufnr = FIND_BUFFER_BY_NAME("/tmp/netbuild")
	if bufnr == nil or bufnr == "" then
		vim.cmd("vnew /tmp/netbuild")
	  bufnr = FIND_BUFFER_BY_NAME("/tmp/netbuild")
	end
	ATTACH_TO_BUFFER(tonumber(bufnr), pattern, command)
end, {})
