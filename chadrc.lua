-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local highlights = require "highlights"

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "gruvbox_light" },
  cheatsheet = { theme = "grid" },
  transparency = false,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "cwd", "lsp", "cursor", "copilot" },
    modules = {
      -- remove the "LSP ~" string from lsp name
      lsp = function()
        local utils = require "nvchad.stl.utils"
        if rawget(vim, "lsp") then
          for _, client in ipairs(vim.lsp.get_active_clients()) do
            if client.attached_buffers[utils.stbufnr()] and client.name ~= "copilot" then
              return (vim.o.columns > 100 and "%#st_lspicon#▍ ▐%#st_lsp#" .. client.name .. " ")
                or "%#st_lspicon#▍ ▐"
            end
          end
        end
        return ""
      end,
      cursor = function()
        return "%#St_pos_icon#▍ %#St_Pos_text# %p%% "
      end,
      copilot = function()
        local utils = require "nvchad.stl.utils"
        if rawget(vim, "lsp") then
          for _, client in ipairs(vim.lsp.get_active_clients()) do
            if client.attached_buffers[utils.stbufnr()] and client.name == "copilot" then
              local c = require "copilot.client"
              return (c.is_disabled()) and "" or "%#St_CopilotSep# %#St_Copilot#  %#St_CopilotSep#▌"
            end
          end
        end
        return ""
      end,
      -- cwd = function()
      --   local file = require("nvchad.stl.utils").file()
      --   local name = vim.loop.cwd()
      --   name = name:match "([^/\\]+)[/\\]*$" or name
      --   return "%#St_cwd_text# " .. file[1] .. " " .. name .. "/" .. file[2] .. " "
      -- end,
    },
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
  },

  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
}

return M
