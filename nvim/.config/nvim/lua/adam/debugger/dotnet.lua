local home = os.getenv("HOME")
local dap = require("dap")
require("nvim-dap-virtual-text").setup()

dap.adapters.netcoredbg = {
	type = "executable",
	command = home .. "/.local/share/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}


dap.configurations.cs = {
	{
		type = "netcoredbg",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			vim.api.nvim_command("write")
			local dir = FIRST_UPSTREAM_FOLDER_CONTAINING_FILE("*.csproj")
			local endingDir = TRIM_TO_CURRENT_DIRECTORY_FROM_FULL_PATH(dir)
			-- vim.cmd(string.format("!dotnet build %s", dir))
			return vim.fn.input("Path to dll: ", dir .. "/bin/Debug/net6.0/" .. endingDir .. ".dll", "file") -- can subsitute ** for net6.0
		end,
	},
	{
		type = "netcoredbg",
		name = "attach - netcoredbg",
		request = "attach",
		processId = function()
			local pid = require("dap.utils").pick_process()
			vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
			return pid
		end,
	},
}
