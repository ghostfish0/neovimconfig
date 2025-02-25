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
local in_mathzone = utils.in_mathzone
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {}, {
  s("mq",
    fmta("\\begin{bmatrix} <> \\end{bmatrix}<>",
      { i(1),
        i(0),
      }
    ),
    { condition = in_mathzone - line_begin }
  ),
  s("mq",
    fmta(
      [[
      \begin{bmatrix}
      <>
      \end{bmatrix}<>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * in_mathzone }
  ),
  s("case",
    fmta(
      [[
      \begin{cases}
      <>
      \end{cases}<>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = in_mathzone }
  ),
  s("all",
    fmta(
      [[
      \begin{aligned}
      <>
      \end{aligned}<>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * in_mathzone }
  ),
  s("new",
    fmta(
      [[
      \begin{<>}
      <>
      \end{<>}<>
      ]],
      {
        i(1),
        i(2),
        rep(1),
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  s("new",
    fmta("\\begin{<>} <> \\end{<>}<>",
      {
        i(1),
        i(2),
        rep(1),
        i(0),
      }
    ),
    { condition = in_mathzone - line_begin }
  ),
  s("nn",
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
  s("mm",
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
