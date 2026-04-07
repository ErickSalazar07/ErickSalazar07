return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree panel" })

      vim.keymap.set("n", "<leader><F6>", function()
        vim.bo.undofile = not vim.bo.undofile
        print("Persistent undotree for this file: "..(vim.bo.undofile and "ON" or "OFF"))
      end, { desc = "Toggle persistent undo for current buffer" })
    end
  }
}
