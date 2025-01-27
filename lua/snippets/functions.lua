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

M.cc = { -- types
  ["i"] = "int",
  ["l"] = "ll",
  ["b"] = "bool",
  ["c"] = "char",
  ["d"] = "double",
  ["f"] = "float",
  ["s"] = "string",
}

M.ds = { -- data structures
  ["p"] = "pair",
  ["m"] = "map",
  ["v"] = "vector",
  -- ["s"] = "set",
}

M.cpfcc = function(capture) -- competitive programming fast class completion
  if capture == nil then
    return "*"
  end
  if M.cc[capture] then
    return M.cc[capture]
  end
  local _, _, head, tail = string.find(capture, "([%a])(%a+)")
  if head == nil or tail == nil then
    return "*"
  elseif string.find("vs", head) then
    return M.ds[head] .. "<" .. M.cpfcc(tail) .. ">"
  elseif string.find("pm", head) then
    return M.ds[head] .. "<" .. (M.cc[tail:sub(1, 1)] or "*") .. ", " .. (M.cc[tail:sub(2, 2)] or "*") .. ">"
  end
  return "*"
end

return M
