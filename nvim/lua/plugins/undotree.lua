return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree panel" })

      vim.keymap.set("n", "<leader>up", function()
        vim.bo.undofile = not vim.bo.undofile
        print("Persistent undotree for this file: "..(vim.bo.undofile and "ON" or "OFF"))
      end, { desc = "Toggle persistent undo for current buffer" })
    end
  }
}
