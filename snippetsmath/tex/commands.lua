local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "snippets.functions"
local get_visual = utils.get_visual
local in_mathzone = utils.in_mathzone_latex
return {
  s(
    { trig = "tbb", dscr = "Expands 'tbb' into LaTeX's textbf{} command", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "ttt", dscr = "Normal text", snippetType = "autosnippet" },
    fmta("\\text{<>}", {
      d(1, get_visual),
    }, { condition = in_mathzone })
  ),
  s(
    { trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command", snippetType = "autosnippet" },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s("todo",  -- "Expands todo{}
    fmta("\\todo{<>}", {
      d(1, get_visual),
    })
  ),
}
