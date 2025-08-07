vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function ()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})
