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
  s("FORU", fmt("FORU({}, {}, {}) {}", { i(1), i(2), i(3), i(4) })),
  s("FORD", fmt("FORD({}, {}, {}) {}", { i(1), i(2), i(3), i(4) })),
  s({ trig = "endl", snippetType = "autosnippet" }, t '"\\n"'),
  s("string", t "string"),
  s("yes", t 'cout << "YES";'),
  s("no", t 'cout << "NO";'),
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
