local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
  s(
    { trig = "ttt", dscr = "Normal text", snippetType = "autosnippet" },
    fmta("\\text{ <>}", { d(1, get_visual) }, { condition = in_mathzone })
  ),
  s(
    { trig = "tbb", dscr = "bold text", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", { d(1, get_visual) }, { condition = in_mathzone })
  ),
  s(
    { trig = "tii", dscr = "italic text", snippetType = "autosnippet" },
    fmta("\\textit{<>}", { d(1, get_visual) }, { condition = in_mathzone })
  ),
}
