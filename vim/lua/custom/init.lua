-- Autocommands
vim.api.nvim_create_autocmd("vimenter", {
  pattern = "*",
  nested = true,
  callback = function()
    vim.cmd("colorscheme gruvbox")
  end,
})

vim.api.nvim_create_autocmd("filetype", {
  pattern = "help",
  callback = function()
    vim.keymap.set("n", "<cr>", "<c-]>", { buffer = true })
    vim.keymap.set("n", "<bs>", "<c-T>", { buffer = true })
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
    vim.opt_local.number = false
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- Functions
local eighty_line_state = {}
function EightyLine()
  if not eighty_line_state[vim.fn.bufnr("%")] then
    eighty_line_state[vim.fn.bufnr("%")] = true
    vim.opt.colorcolumn = "80"
    vim.cmd("highlight ColorColumn ctermbg=grey")
  else
    eighty_line_state[vim.fn.bufnr("%")] = nil
    vim.opt.colorcolumn = "80"
    vim.cmd("highlight ColorColumn NONE")
  end
end

function TrimTail()
  local save = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
end

-- Autocmds


vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    command = "set filetype=markdown"
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.justfile",
    command = "set syntax=just"
})