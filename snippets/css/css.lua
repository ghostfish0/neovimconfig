local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node

return {
  s("comment", {
    t({"/* "}),
    ls.insert_node(1),
    t({" */"}),
  })
}

