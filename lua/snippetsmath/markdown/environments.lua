local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
local get_visual = utils.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s(
    { trig = "new", dscr = "A generic new environmennt", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
        <>
      \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "nn", dscr = "nn into math ", snippetType = "autosnippet" },
    fmta(
      [[ 
        $$ 
          <>
        $$
        <>
      ]],
      {
        i(1),
        i(2),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "mm", dscr = "mm into inline math", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
