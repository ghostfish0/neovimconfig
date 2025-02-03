local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    java = { "clang-format" },
    cpp = { "clang-format" },
  },
  formatters = {
    ["clang-format-cpp"] = {
      command = "clang-format",
      env = {
        UseTab = "Always",
        TabWidth = 8,
        IndentWidth = 8,
        ColumnLimit = 10,
        -- AlignArrayOfStructures = "Right",
        -- AlignConsecutiveAssignments = "Consecutive",
        AlignConsecutiveMacros = "Consecutive",
        AlignAfterOpenBracket = "Align",
        AllowAllArgumentsOnNextLine = true,
        AllowShortCaseExpressionOnASingleLine = true,
        BinPackArguments = false,
        BinPackParameters = false,
      },
    },
    ["clang-format"] = {
      env = {
        UseTab = "Always",
        TabWidth = 4,
        IndentWidth = 4,
        ColumnLimit = 10,
        -- AlignArrayOfStructures = "Right",
        -- AlignConsecutiveAssignments = "Consecutive",
        AlignConsecutiveMacros = "Consecutive",
        AlignAfterOpenBracket = "Align",
        AllowAllArgumentsOnNextLine = true,
        AllowShortCaseExpressionOnASingleLine = true,
        BinPackArguments = false,
        BinPackParameters = false,
      },
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
