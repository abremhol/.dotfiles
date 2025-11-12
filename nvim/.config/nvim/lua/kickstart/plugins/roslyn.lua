local function find_solution_or_project()
  local cwd = vim.fn.getcwd()
  local sln = vim.fn.globpath(cwd, '*.sln', false, true)
  local csproj = vim.fn.globpath(cwd, '*.csproj', false, true)
  if #sln > 0 then
    return sln[1]
  elseif #csproj > 0 then
    return csproj[1]
  end
  return nil
end

return {
  'seblyng/roslyn.nvim',
  ft = 'cs',
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    solution_or_project = find_solution_or_project(),
    -- your configuration comes here; leave empty for default settings
    -- NOTE: You must configure `cmd` in `config.cmd` unless you have installed via mason
  },
}
