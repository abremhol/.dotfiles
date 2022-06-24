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

require("nvim-dap-virtual-text").setup()
local dap = require("dap")
dap.adapters.netcoredbg = {
	type = "executable",
	command = "/home/adam/.local/share/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "netcoredbg",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			local dir = vim.fn.expand("%:p:h")

			local lastfolder = ""
			local csprojFile = ""
			while dir ~= lastfolder and (csprojFile == nil or csprojFile == "") do
				csprojFile = vim.fn.globpath(dir, "*.csproj")
				lastfolder = dir
				dir = vim.fn.fnamemodify(dir, ":h")
			end
			if csprojFile == nil or csprojFile == "" or dir == lastfolder then
				dir = vim.fn.expand("%:p:h")
			else
				dir = lastfolder
			end
			local endingDirIndex = ""
			local i = 0
			while true do
				i = string.find(dir, "/", i + 1) -- find 'next' /
				if i == nil then
					break
				end
				endingDirIndex = i
			end
			local endingDir = string.sub(dir, endingDirIndex + 1, string.len(dir))
			vim.cmd(string.format("!dotnet build %s", dir))
			return vim.fn.input("Path to dll: ", dir .. "/bin/Debug/net6.0/" .. endingDir .. ".dll", "file")
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
