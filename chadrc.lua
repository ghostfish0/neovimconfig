-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local highlights = require "highlights"
local overrides = require "configs.overrides".chadrc

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "everforest_light" },
  cheatsheet = { theme = "grid" },
  transparency = false,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = overrides.statusline,
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
}

return M
