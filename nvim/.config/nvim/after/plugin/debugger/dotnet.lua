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
			if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
				vim.g.dotnet_build_project()
			end
			return vim.g.dotnet_get_dll_path()
		end,
	},
	{
		type = "netcoredbg",
		name = "launch norebuild - netcoredbg",
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
			return vim.fn.getenv("NETCOREDBG_ATTACH_PID")
		end,
	},
}
vim.g.set_process_id = function()
	local pid = require("dap.utils").pick_process()
	vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
	local mConfig = nil
	for _, value in pairs(dap.configurations.cs) do
		if value.request == "attach" then
			mConfig = value
		end
	end
	dap.run(mConfig)
end

vim.g.dotnet_build_project = function()
	local default_path = FIRST_UPSTREAM_FOLDER_CONTAINING_FILE("*.sln")
	if vim.g["dotnet_last_proj_path"] ~= nil then
		default_path = vim.g["dotnet_last_proj_path"]
	end
	local path = vim.fn.input("Path to your *proj file", default_path, "file")
	vim.g["dotnet_last_proj_path"] = path
	local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
	print("")
	print("Cmd to execute: " .. cmd)
	local f = os.execute(cmd)
	if f == 0 then
		print("\nBuild: ✔️ ")
	else
		print("\nBuild: ❌ (code: " .. f .. ")")
	end
end

vim.g.dotnet_get_dll_path = function()
	local request = function()
		return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/net6.0/", "file")
	end

	if vim.g["dotnet_last_dll_path"] == nil then
		vim.g["dotnet_last_dll_path"] = request()
	else
		if
			vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2)
			== 1
		then
			vim.g["dotnet_last_dll_path"] = request()
		end
	end

	return vim.g["dotnet_last_dll_path"]
end
