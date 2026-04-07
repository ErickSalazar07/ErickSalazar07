local augroup = vim.api.nvim_create_augroup("WhiteSpacesManager", { clear = true })

vim.g.trim_whitespace_on_save = true

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function()
    if not vim.g.trim_whitespace_on_save then
      return
    end

    if vim.bo.buftype ~= "" then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_create_user_command("TrimWhitespaceToggle", function()
  vim.g.trim_whitespace_on_save = not vim.g.trim_whitespace_on_save

  if vim.g.trim_whitespace_on_save then
    print("Trim whitespace on save: ON")
  else
    print("Trim whitespace on save: OFF")
  end
end, {})

local secret_group = vim.api.nvim_create_augroup("SecretEditing", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
  group = secret_group,
  pattern = { "/dev/shm/*", "/tmp/*", "/private/tmp/*" },
  callback = function(args)
    local name = vim.api.nvim_buf_get_name(args.buf)

    if name:match("^/tmp/") or name:match("^/dev/shm/") or name:match("^/private/tmp/") then
      -- buffer-local
      vim.bo[args.buf].undofile = false
      vim.bo[args.buf].swapfile = false
      vim.bo[args.buf].modeline = false

      -- no buffer-local: aplicar localmente donde se pueda con :setlocal
      vim.cmd("setlocal nobackup nowritebackup")

      vim.b[args.buf].is_secret_buffer = true
    end
  end,
})
