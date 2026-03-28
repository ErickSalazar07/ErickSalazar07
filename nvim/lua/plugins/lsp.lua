return {
  {
    "neovim/nvim-lspconfig",
    commit = "v0.1.7",
    config = function()
      local caps = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
      })

      -- Rounded floating windows
      local orig = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        opts.max_width = opts.max_width or 80
        opts.max_height = opts.max_height or 24
        opts.wrap = opts.wrap ~= false
        return orig(contents, syntax, opts, ...)
      end

      -- LSP keymaps + behaviors
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local buf = args.buf

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
          map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
          map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "x" }, "<F3>", function()
            vim.lsp.buf.format({ async = true })
          end, "Format buffer/selection")
          map("n", "<F4>", vim.lsp.buf.code_action, "Code action")

          -- Highlight symbol under cursor
          if client.supports_method and client:supports_method("textDocument/documentHighlight") then
            local highlight_augroup =
            vim.api.nvim_create_augroup("my.lsp.highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Autoformat on save (solo Java)
          local format_on_save = {
            java = true,
          }

          if client.supports_method
            and not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
            and format_on_save[vim.bo[buf].filetype]
            then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp.format", { clear = false }),
                buffer = buf,
                callback = function()
                  vim.lsp.buf.format({
                    bufnr = buf,
                    id = client.id,
                    timeout_ms = 1000,
                  })
                end,
              })
            end
          end,
        })

        -- C / C++
        lspconfig.clangd.setup({
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
          },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = util.root_pattern(
          "compile_commands.json",
          ".clangd",
          "Makefile",
          ".git"
          ),
          capabilities = caps,
        })

        -- Java
        lspconfig.jdtls.setup({
          cmd = { "jdtls" },
          filetypes = { "java" },
          root_dir = util.root_pattern(
          "gradlew",
          "mvnw",
          "pom.xml",
          "build.gradle",
          ".git"
          ),
          capabilities = caps,
        })

        -- Treat .h as C
        vim.filetype.add({
          extension = {
            h = "c",
          },
        })
      end,
    },
  }
