local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    java = { "clang-format" },
  },
  formatters = {
    ["clang-format"] = {
      env = {
        TabWidth = 4,
        UseTab = "Always",
        IndentWidth = 4,
        ContinuationIndentWidth = 4,
        ColumnLimit = 10,

      }
    },
  }

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
