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
  ["MatchParen"] = { bg = "red" },
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
  St_cwd_text = { bold = true, bg = "statusline_bg" },
  St_Lsp = { fg = "cyan", bg = "statusline_bg", bold = true },
  St_pos_text = { fg = "yellow", bg = "statusline_bg", bold = true },
  St_pos_icon = { bg = "yellow", fg = "black" },
  NvimTreeRootFolder = { fg = "cyan", bold = false },
  TelescopeSelection = { bold = true },
}

---@type HLTable
M.add = {
  ["@string.special.url.html"] = { fg = "blue" },
  markdownRule = { fg = "cyan" },
  markdownCodeblock = { fg = "orange" },
  markdownCodeDelimiter = { fg = "vibrant_green" },
  markdownBold = { fg = "cyan", bold = true },
  DiagnosticUnnecessary = { fg = "purple", italic = true },
  St_LspIcon = { bg = "cyan", fg = "black" },
  St_Copilot = { bg = "vibrant_green", fg = "black" },
  St_CopilotSep = { bg = "black", fg = "vibrant_green" },
  St_CopilotDisabled = { bg = "black", fg = "red" },
  CmpItemKindCopilot = { bg = "vibrant_green", fg = "black" },
  IblIndent = { fg = "one_bg" },
  IblScope = { fg = "grey" },
  CursorLine = { bg = "white" },
  -- rainbow headers
  ["@markup.heading.1.markdown"] = { fg = "red", bold = true },
  ["@markup.heading.2.markdown"] = { fg = "orange", bold = true },
  ["@markup.heading.3.markdown"] = { fg = "yellow", bold = true },
  ["@markup.heading.4.markdown"] = { fg = "green", bold = true },
  ["@markup.heading.5.markdown"] = { fg = "blue", bold = true },
  --
  ["@markup.link.label.markdown_inline"] = { fg = "yellow" },
  ["@lsp.type.class.markdown"] = { fg = "yellow" },
  ["@markup.link.url.markdown_inline"] = { italic = true, fg = "cyan", underline = false },
  ["@markup.heading.6.markdown"] = { fg = "purple", bold = true },
  ["@punctuation.delimiter.markdown_inline"] = { fg = "grey_fg" },
  ["@conceal.markdown_inline"] = { fg = "grey_fg" },
  ["@punctuation.special.markdown"] = { fg = "cyan" },
  --
  TreesitterContext = { bg = "black" },
  TreesitterContextSeparator = { fg = "cyan" },
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  NvimTreeCopiedHL = { underline = true },
  NvimTreeCutHL = { underline = true },
  AerialNormal = { fg = "green" },
  helpExample = M.markdownCodeblock,
}

return M
