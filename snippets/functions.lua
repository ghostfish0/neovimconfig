local ls = require "luasnip"
-- local s = ls.snippet
local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmta = require("luasnip.extras.fmt").fmta

local M = {}
M.get_visual = function(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
M.in_mathzone_markdown = function()
  -- The `in_mathzone` function requires the Nabla plugin
  return require("nabla.utils").in_mathzone()
end
M.in_mathzone_latex = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn["vimtex#syntax#in_mathzone"]()
end

return M
