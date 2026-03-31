return {
  {
    "tpope/vim-fugitive",
    config = function() -- Git command with fugitive plugin managment keybindings
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Enters Git(fugitive) command for status" })
      vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Enters Git(fugitive) command for commiting" })
      vim.keymap.set("n", "<leader>ga", "<cmd>Git add -p<CR>", { desc = "Enters Git(fugitive) command for adding in patch mode" })
      vim.keymap.set("n", "<leader>gd", "<cmd>Git diff --staged<CR>", { desc = "Enters Git(fugitive) command for diff in the index/stage" })
      vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Enters Git(fugitive) command for checking logs" })
    end
  }
}

