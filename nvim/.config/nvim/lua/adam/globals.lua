local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
	reloader = require
else
	reloader = plenary_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return reloader(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

FIND_BUFFERS = function()
	local results = {}
	local buffers = vim.api.nvim_list_bufs()

	for _, buffer in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			local filename = vim.api.nvim_buf_get_name(buffer)
			table.insert(results, buffer, filename)
		end
	end
	return results
end

FIND_BUFFER_BY_NAME = function(name)
	local named_buffers = FIND_BUFFERS()
  P(named_buffers)
	for k, v in pairs(named_buffers) do
		if v == name then
			return k
		end
	end
	return nil
end
