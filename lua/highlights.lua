-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { italic = true },
  ["@comment"] = { italic = true },
  Identifier = { bold = true },
  ["@markup.heading"] = { bold = true },
  MatchParen = { fg = "NONE", bg = "one_bg2" },
  MatchParenCur = { fg = "NONE", bg = "one_bg2" },
  MatchWord = { fg = "NONE", bg = "one_bg2" },
  -- MatchParen = { fg = "NONE", bg = "NONE", underline = true },
  -- MatchParenCur = { fg = "NONE", bg = "NONE", underline = true },
  -- MatchWord = { fg = "NONE", bg = "NONE", underline = true },
  ["@markup.strong"] = { fg = "red", bold = true },
  ["@markup.italic"] = { fg = "yellow", italic = true },
  ["@markup.strikethrough"] = { underline = true, italic = true, fg = "red" },
  --
  St_InsertmodeText = { bold = true },
  St_NormalmodeText = { bold = true },
  St_VisualmodeText = { bold = true },
  St_CommandmodeText = { bold = true },
  St_ReplacemodeText = { bold = true },
  St_TerminalmodeText = { bold = true },
  St_NTerminalmodeText = { bold = true },
  St_cwd_text = { bold = true, fg="red", bg = "statusline_bg" },
  St_Lsp = { fg = "cyan", bg = "statusline_bg", bold = true },
  St_LspIcon = { bold = true },
  St_pos_text = { fg = "yellow", bg = "statusline_bg", bold = true },
  St_pos_icon = { bg = "yellow", fg = "black", bold = true },
  NvimTreeRootFolder = { fg = "cyan", bold = false },
  TelescopeSelection = { bold = true },
  Include = { fg = "dark_purple" },
}

---@type HLTable
M.add = {
  ["@keyword.directive.cpp"] = { fg = "dark_purple" },
  ["@keyword.directive.define.cpp"] = { fg = "dark_purple" },
  ["@keyword.conditional.cpp"] = { fg = "green" },
  ["@keyword.repeat.cpp"] = { fg = "sun" },
  ["@operator.cpp"] = { fg = "cyan" },
  ["@number.cpp"] = { fg = "white" },
  ["@variable.cpp"] = { fg = "white" },
  ["@constant.cpp"] = { italic = true, fg = "red" },
  ["@constant.builtin.cpp"] = { italic = true, fg = "red" },
  ["@character.cpp"] = { fg = "green" },
  ["@function.call.cpp"] = { fg = "green" },
  ["@string.escape.cpp"] = { fg = "dark_purple" },
  ["@punctuation.bracket.cpp"] = { fg = "orange" },
  ["@punctuation.delimiter.cpp"] = { fg = "orange" },

  ["@string.special.url.html"] = { fg = "blue" },
  -- rainbow headers
  ["@markup.heading.1.markdown"] = { fg = "red", bold = true },
  ["@markup.heading.2.markdown"] = { fg = "orange", bold = true },
  ["@markup.heading.3.markdown"] = { fg = "yellow", bold = true },
  ["@markup.heading.4.markdown"] = { fg = "green", bold = true },
  ["@markup.heading.5.markdown"] = { fg = "blue", bold = true },
  ["@markup.link.label.markdown_inline"] = { fg = "yellow" },
  ["@lsp.type.class.markdown"] = { fg = "yellow" },
  ["@markup.link.url.markdown_inline"] = { italic = true, fg = "cyan", underline = false },
  ["@markup.heading.6.markdown"] = { fg = "purple", bold = true },
  ["@punctuation.delimiter.markdown_inline"] = { fg = "grey_fg" },
  ["@conceal.markdown_inline"] = { fg = "grey_fg" },
  ["@punctuation.special.markdown"] = { fg = "cyan" },
  markdownRule = { fg = "cyan" },
  markdownCodeblock = { fg = "orange" },
  markdownCodeDelimiter = { fg = "vibrant_green" },
  markdownBold = { fg = "cyan", bold = true },
  --
  TreesitterContext = { bg = "black" },
  TreesitterContextSeparator = { fg = "cyan" },
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  NvimTreeCopiedHL = { underline = true },
  NvimTreeCutHL = { underline = true },
  AerialNormal = { fg = "green" },
  helpExample = M.markdownCodeblock,
  St_LspIcon = { bg = "cyan", fg = "black" },
  St_Copilot = { bg = "vibrant_green", fg = "black" },
  St_CopilotSep = { bg = "black", fg = "vibrant_green" },
  St_CopilotDisabled = { bg = "black", fg = "red" },
  CmpItemKindCopilot = { bg = "vibrant_green", fg = "black" },
  DiagnosticUnnecessary = { fg = "purple", italic = true },
  IblIndent = { fg = "one_bg" },
  CursorLine = { bg = "white" },
}

return M
