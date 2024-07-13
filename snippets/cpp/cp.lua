local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
-- local get_visual = utils.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s("FOR", fmt("FOR({}, {}, {}) {}", { i(1), i(2), i(3), i(4) })),
  s("FORD", fmt("FORD({}, {}, {}) {}", { i(1), i(2), i(3), i(4) })),
  s({ trig = "endl", snippetType = "autosnippet" }, t "\"\\n"),
}
