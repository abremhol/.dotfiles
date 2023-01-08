local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

daptext.setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

--Extra keymaps for arrow keys
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle(2)
end)

vim.keymap.set("n", "<leader>dx", function()
	dap.close()
end)

vim.keymap.set("n", "<Up>", function()
	dap.continue()
end)
vim.keymap.set("n", "<Down>", function()
	dap.step_over()
end)
vim.keymap.set("n", "<Right>", function()
	dap.step_into()
end)
vim.keymap.set("n", "<Left>", function()
	dap.step_out()
end)

vim.keymap.set("n", "<leader>db", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

vim.keymap.set("n", "<leader>dc", function()
	dap.continue()
end)

vim.keymap.set("n", "<leader>do", function()
	dap.step_over()
end)

vim.keymap.set("n", "<leader>di", function()
	dap.step_into()
end)

vim.keymap.set("n", "<leader>dcl", function()
	dap.clear_breakpoints()
end)

vim.keymap.set("n", "<leader>dr", function()
	dap.repl.toggle()
end)

vim.keymap.set("n", "<leader>dx", function()
	dap.terminate()
end)

vim.keymap.set("n", "<leader>dl", function()
	dap.run_last()
end)

vim.keymap.set("n", "<leader>ds", function()
	vim.g.set_process_id()
end)

-- Deletes previous K keymap and hovers with K then restores K
local api = vim.api
local keymap_restore = {}
dap.listeners.after["event_initialized"]["me"] = function()
	for _, buf in pairs(api.nvim_list_bufs()) do
		local keymaps = api.nvim_buf_get_keymap(buf, "n")
		for _, keymap in pairs(keymaps) do
			if keymap.lhs == "K" then
				table.insert(keymap_restore, keymap)
	           vim.keymap.del("n", "K", {buffer = buf})
			end
		end
	end
	vim.keymap.set("n", "K", function()
		dapui.eval()
	end)
end

dap.listeners.after["event_terminated"]["me"] = function()
	vim.keymap.del("n", "K")
	for _, keymap in pairs(keymap_restore) do
		if keymap.rhs ~= nil then
			vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, { buffer = keymap.buffer, silent = keymap.silent == 1 })
		end
	end
	keymap_restore = {}
end
