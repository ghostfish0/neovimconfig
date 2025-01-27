local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
-- local get_visual = utils.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s("builtin_ctz", { t "__builtin_ctz(", i(1), t ")" }),
  s("string", t "string"),
  s("break", t "break"),
  s("using", t "using"),
  s("continue", t "continue"),
  s("return", t "return"),
  s("push_back", t "push_back"),
  s(
    "template",
    fmt(
      [[
        template <{}> 
        {} {}({}) {{
          {}
        }}
      ]],
      {
        i(1, "typename T"), -- Insert node for the template parameter
        i(2, "void"), -- Insert node for the return type
        i(3, "functionName"), -- Insert node for the function name
        i(4), -- Insert node for the function parameters
        i(5), -- Insert node for the function body
      }
    )
  ),
  s(
    "if",
    fmt(
      [[
        if ({}) {{
          {}
        }}
      ]],
      {
        i(1), -- Insert node for the condition
        i(2), -- Insert node for the code inside the loop
      }
    )
  ),
  s(
    "while",
    fmt(
      [[
        while ({}) {{
            {}
        }}
      ]],
      {
        i(1), -- Insert node for the condition
        i(2), -- Insert node for the code inside the loop
      }
    )
  ),
  s({ trig = "endl", snippetType = "autosnippet" }, t '"\\n"'),
  s({
    trig = "([pvsm]%a+)%s",
    desc = "FastOlympic Class Completion",
    regTrig = true,
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      local cc = utils.cpfcc(snip.captures[1])
      if cc:find "%*" then
        print "Fast Class Completion invalid!"
        cc = snip.captures[1]
      end
      return cc .. " "
    end),
    i(0),
  }, { condition = line_begin }),
}
