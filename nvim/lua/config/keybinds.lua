vim.g.mapleader = " "

-- buffer management
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>D", "<cmd>bdelete!<CR>", { desc = "Force close window" })
vim.keymap.set("n", "<leader>q", "<cmd>wqa<CR>", { desc = "Save and quit all" })
vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- file movement management
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center view when going half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center view when going half page up" })
vim.keymap.set("n", "n", "nzz", { desc = "Center view when searching patterns" })
vim.keymap.set("n", "N", "Nzz", { desc = "Center view when searching backward patterns" })

-- pane management
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Alias for managing windows" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- copying management
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard normal mode" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to system clipboard visual mode" })
vim.keymap.set("n", "Y", "yg$", { desc = "Copy logical line" })

-- pasting management
vim.keymap.set("n", "<leader>P", "\"+P", { desc = "Paste from system clipboard before the cursor" })
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "Paste from system clipboard after the cursor" })
vim.keymap.set("x", "<leader>P", "\"_dP", { desc = "Paste without override the clipboard" })
vim.keymap.set("x", "<leader>p", "\"_d\"+P", { desc = "Overrides text with system clipboard content" })

-- spelling management
vim.keymap.set("n", "<leader>s",
  function()
    vim.opt_local.spell = not vim.opt_local.spell:get()

    local lang = vim.bo.spelllang
    local active = vim.opt_local.spell:get() and "ON" or "OFF"

    print("Spell(" .. lang .. "): " .. active)
  end,
  { desc = "Toggle spell checking" }
)

-- dynamic gq command
local function dynamic_gq()
  local win_width = vim.api.nvim_win_get_width(0)
  local margin = 6
  vim.opt_local.textwidth = math.max(20, win_width - margin)
  return "gq"
end

-- code edition management
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Moves code in visual mode to 1 line upper" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Moves code in visual mode to 1 line down" })
vim.keymap.set({ "n", "x" }, "gq", dynamic_gq, {
  expr = true,
  desc = "Dynamic gq based on window width",
})

-- netrw management
vim.keymap.set("n", "<leader>t", vim.cmd.Ex, { desc = "Open Explore command" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local opts = { buffer = true, remap = true }
    vim.keymap.set("n", "l", "<CR>", opts)
    vim.keymap.set("n", "h", "-", opts)
  end,
})
