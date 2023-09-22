local M = {}

M.copySelectionOrWhole = function()
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'v' or mode == 'V' or mode == '\22' then -- Check if in visual mode
    vim.api.nvim_command('normal! "+y')
  else
    vim.api.nvim_command('normal! ggVG"+y')
  end
end

return M

