-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.hlsearch = true
vim.opt.spell = false

vim.opt.swapfile = false
vim.opt.writebackup = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.undofile = true

vim.opt.listchars = {
  tab = "→ ",
  eol = "↲",
  nbsp = "␣",
  trail = "~",
  extends = "⟩",
  precedes = "⟨",
  space = "•",
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.relativenumber = true
vim.opt.background = "dark"
vim.opt.nrformats:append("alpha")

vim.g.rzipPlugin_extra_ext = "*.pak"
vim.g.vimwiki_global_ext = 0

local wiki_1 = {}
wiki_1.path = "~/vimwiki/"
wiki_1.automatic_nested_syntaxes = 1
wiki_1.ext = ".wik"
wiki_1.diary_rel_path = "journal/"
wiki_1.diary_index = "journal"
wiki_1.diary_header = "Journal"
wiki_1.diary_sort = "desc"
vim.g.vimwiki_list = { wiki_1 }

vim.g.go_def_mode = "gopls"
vim.g.go_info_mode = "gopls"
vim.g.go_code_completion_enabled = 1

if os.getenv("TMUX") then
  vim.g.fzf_layout = { tmux = "-p90%,60%" }
else
  vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
end

vim.g.airline_theme = "gruvbox"
vim.g.airline_gruvbox_bg = "dark"
vim.g.VimuxUseNearest = 0
vim.g.task_default_prompt = { "due", "scheduled", "tag", "description" }
vim.g.indent_guides_enable_on_vim_startup = 1

vim.g.tmuxline_powerline_separators = 0
vim.g.tmuxline_preset = {
  a = "#{=6:session_name}",
  b = "#P:#{=6:pane_current_command}",
  c = " ",
  win = "#I:#{=6:window_name}",
  cwin = "#I:#{=6:window_name}#F",
  x = "%b-%a",
  y = "%m-%d",
  z = "%H:%M",
}

-- vim: ts=2 sts=2 sw=2 et