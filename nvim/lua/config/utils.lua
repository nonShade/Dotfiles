local M = {}

function M.save_file()
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("No file to save", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t")
  local success, err = pcall(function()
    vim.cmd("silent! write")
  end)

  if success then
    vim.notify(filename .. " Saved!")
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR)
  end
end

return M