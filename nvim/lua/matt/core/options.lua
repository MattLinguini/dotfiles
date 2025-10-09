vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbering
opt.relativenumber = true
opt.number = true

-- tabs & indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- styling
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true
