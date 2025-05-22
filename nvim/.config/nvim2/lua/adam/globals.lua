P = function(v)
	print(vim.inspect(v))
	return v
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
	for k, v in pairs(named_buffers) do
		if v == name then
			return k
		end
	end
	return nil
end

FIRST_UPSTREAM_FOLDER_CONTAINING_FILE = function(s)
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

TRIM_TO_CURRENT_DIRECTORY_FROM_FULL_PATH = function(dir)
	local endingDirIndex = dir.length
	local i = 0
	while true do
		i = string.find(dir, "/", i + 1) -- find 'next' /
		if i == nil then
			break
		end
		endingDirIndex = i
	end
    local res = string.sub(dir, endingDirIndex + 1, string.len(dir))
	return res
end
