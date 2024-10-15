-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
---@type ChadrcConfig
local M = {}

local highlights = require "highlights"
local overrides = require("configs.overrides").chadrc

M = {
  ui = {
    statusline = overrides.statusline,
    tabufline = overrides.tabufline,
    cmp = {
      -- style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
      icons = true,
      icons_left = true,
    },
    telescope = { style = "borderless" },
  },
  cheatsheet = { theme = "grid" },
  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
  base46 = {
    theme = "gruvbox",
    theme_toggle = { "gruvbox", "gruvbox" },
    transparency = false,
    hl_override = highlights.override,
    hl_add = highlights.add,
  },
  mason = {
    cmd = true,
    pkgs = {
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
      -- "marksman",
    },
  },
}

return M
