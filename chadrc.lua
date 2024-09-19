-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local highlights = require "highlights"
local overrides = require "configs.overrides".chadrc

M.ui = {
  cheatsheet = { theme = "grid" },

  statusline = overrides.statusline,
  tabufline = overrides.tabufline,
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },

  mason = { cmd = true, pkgs = {
        -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "glsl_analyzer",
    "rust_analyzer",

    -- python stuff
    "black",
    "pyright",

    -- note-taking stuff
    "marksman",
  }}
}

M.base46 = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "gruvbox" },
  transparency = false,
  hl_override = highlights.override,
  hl_add = highlights.add,
}

return M
