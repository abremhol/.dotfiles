require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7"),
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position.
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

local home = os.getenv("HOME")
require("nvim-dap-virtual-text").setup()
local dap = require("dap")
dap.adapters.netcoredbg = {
	type = "executable",
	command = home .. "/.local/share/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

local firstParentFolderContainingFile = function(s)
	local dir = vim.fn.expand("%:p:h")

	local lastfolder = ""
	local csprojFile = ""
	while dir ~= lastfolder and (csprojFile == nil or csprojFile == "") do
		csprojFile = vim.fn.globpath(dir, s)
		lastfolder = dir
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	if csprojFile == nil or csprojFile == "" or dir == lastfolder then
		dir = vim.fn.expand("%:p:h")
	else
		dir = lastfolder
	end
	return dir
end

local currentDirectoryFromFullPath = function(dir)
	local endingDirIndex = ""
	local i = 0
	while true do
		i = string.find(dir, "/", i + 1) -- find 'next' /
		if i == nil then
			break
		end
		endingDirIndex = i
	end
	return string.sub(dir, endingDirIndex + 1, string.len(dir))
end

dap.set_log_level("TRACE")

dap.configurations.cs = {
	{
		type = "netcoredbg",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			vim.api.nvim_command("write")
			local dir = firstParentFolderContainingFile("*.csproj")
			local endingDir = currentDirectoryFromFullPath(dir)
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

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { home .. "/.local/share/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.loop.cwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process
		-- is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = {
	{
		name = "ts-node (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "-r", "ts-node/register" },
		runtimeExecutable = "node",
		args = { "--inspect", "${file}" },
		sourceMaps = true,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
	{
		name = "Jest (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
		runtimeExecutable = "node",
		args = { "${file}", "--runInBand", "--coverage", "false" },
		sourceMaps = true,
		port = 9229,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
}
