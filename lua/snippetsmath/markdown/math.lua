local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "snippets.functions"
local in_mathzone = utils.in_mathzone_markdown

return {
  -- expressions
  s(
    { trig = "([%a]);", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>(<>)<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%a])(%d+)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_<> <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])pp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>} <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])ss", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>} <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{0} <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "dint", snippetType = "autosnippet" },
    fmta("\\int_{<>}^{<>} <> \\,dx <>", { i(1), i(2), i(3), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "int", snippetType = "autosnippet" },
    fmta("\\int <> \\,dx <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "sum", snippetType = "autosnippet" },
    fmta("\\sum_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }
  ),
  s({ trig = "lim", snippetType = "autosnippet" }, fmta("\\lim_{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s(
    { trig = "^=", snippetType = "autosnippet" },
    fmta("\\stackrel{<>}{=} <>", { i(1), i(0) }, { condition = in_mathzone })
  ),
  s(
    { trig = "ff", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
  s({ trig = "rr", snippetType = "autosnippet" }, fmta("\\sqrt{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s(
    { trig = "vv", snippetType = "autosnippet" },
    fmta("\\overrightarrow{<>} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  -- s(
  --   { trig = "(%((.*)%)|(%w))%/", regTrig=true, wordTrig=false, snippetType = "autosnippet" },
  --   fmta("\\frac{<>}{<>} <>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     i(1),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    { trig = "|||", snippetType = "autosnippet" },
    fmta("\\bigg|_{<>}^{<>} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
  -- symbols
  s({ trig = "set", snippetType = "autosnippet" }, fmta("\\{<>\\} <>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "+-", snippetType = "autosnippet" }, t "\\pm", { condition = in_mathzone }),
  s({ trig = "<=", snippetType = "autosnippet" }, t "\\leqslant", { condition = in_mathzone }),
  s({ trig = ">=", snippetType = "autosnippet" }, t "\\geqslant", { condition = in_mathzone }),
  s({ trig = "==", snippetType = "autosnippet" }, t "\\approx", { condition = in_mathzone }),
  s({ trig = "->", snippetType = "autosnippet" }, t "\\rightarrow", { condition = in_mathzone }),
  s({ trig = "=>", snippetType = "autosnippet" }, t "\\Rightarrow", { condition = in_mathzone }),
  s({ trig = "<=>", snippetType = "autosnippet" }, t "\\iff", { condition = in_mathzone }),
  s({ trig = "ll", snippetType = "autosnippet" }, t "&", { condition = in_mathzone }),
  s({ trig = "inf", snippetType = "autosnippet" }, t "\\infty", { condition = in_mathzone }),
  s({ trig = "ee", snippetType = "autosnippet" }, fmta("e^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s({ trig = "*", snippetType = "autosnippet" }, t "\\cdot", { condition = in_mathzone }),
    s({ trig = "tag" }, fmta("\\tag^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
}
