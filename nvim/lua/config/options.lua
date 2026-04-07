-- various styles
vim.opt.guicursor = ""
vim.opt.termguicolors = true

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- panel control
vim.opt.splitright = true
vim.opt.splitbelow = true

-- history config
local undodir = os.getenv("HOME") .. "/.nvim/undodir"
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir,"p") end
vim.opt.history = 100
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = undodir
vim.opt.undofile = false

-- mouse and indentation
vim.opt.autoindent = true
vim.opt.mouse = ""

-- netrw options
vim.g.netrw_list_hide = [[^\./$\|^\.\./$\|^\.git/$\|^node_modules/$\|^\.cache/$]]
vim.g.netrw_hide = 1

-- searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

