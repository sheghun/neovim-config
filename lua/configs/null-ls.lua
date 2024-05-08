local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local options = {
  sources = {
    null_ls.builtins.diagnostics.golangci_lint.with {
      extra_args = { "--fix=true" },
    },
    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.code_actions.impl,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.refactoring,
    require("none-ls.code_actions.eslint"),
    require("none-ls.diagnostics.eslint"),
    require("none-ls.formatting.eslint"),

  },

  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

null_ls.setup(options)
