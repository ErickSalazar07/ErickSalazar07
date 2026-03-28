vim.g.mapleader = " "

vim.keymap.set("n", "<leader>d", "<cmd>bdelete<CR>", { desc = "close window" })
vim.keymap.set("n", "<leader>D", "<cmd>bdelete!<CR>", { desc = "force close window" })
vim.keymap.set("n", "<leader>q", "<cmd>wqa<CR>", { desc = "save and quit all" })
vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "new buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>b #<CR>", { desc = "last buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "next buffer" })

-- pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- ctrl + c system clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- dynamic gq command

local function dynamic_gq()
  local win_width = vim.api.nvim_win_get_width(0)
  local margin = 6
  vim.opt_local.textwidth = math.max(20, win_width - margin)
  return "gq"
end

vim.keymap.set({ "n", "x" }, "gq", dynamic_gq, {
  expr = true,
  desc = "Dynamic gq based on window width",
})
