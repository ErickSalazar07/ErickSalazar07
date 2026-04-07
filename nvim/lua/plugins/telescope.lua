return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "%.cache/",
          "%.Code/",
          "dist/",
          "build/",
          "target/",
          "%.venv/",
          "__pycache__/",
        },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local argc = vim.fn.argc()
        local is_scratch = vim.env.NVIM_SCRATCH == "1"

        if argc == 0 and not is_scratch then
          vim.schedule(function()
            builtin.find_files()
          end)
        end
      end,
    })
  end,
}
