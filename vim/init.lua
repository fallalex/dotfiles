local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
