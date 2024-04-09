local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  -- s( -- New level section with hyperref
  --   { trig = "h1", dscr = "Top-level section" },
  --   fmta([[\section{<>}]], { i(1) }),
  --   { condition = line_begin } -- set condition in the `opts` table
  -- ),
  s(
    { trig = "nn", dscr = "Equation environment with suppressed numbering", snippetType = "autosnippet" },
    fmta(
      [[ 
      \begin{equation*}
        <>
      \end{equation*}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
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
    { trig = "([^%a])mm", dscr = "mm into inline math", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
