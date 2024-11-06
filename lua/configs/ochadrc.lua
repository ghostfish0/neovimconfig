local M = {}
local separator_style = "default"
local separators = {
  default = { left = "", right = "" }, 
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}
local sep_l = separators[separator_style]["left"]
local sep_r = separators[separator_style]["right"]
local modes = {
  ["n"] = { "通常", "Normal" },
  ["no"] = { "通常 (no)", "Normal" },
  ["nov"] = { "通常 (nov)", "Normal" },
  ["noV"] = { "通常 (noV)", "Normal" },
  ["noCTRL-V"] = { "通常", "Normal" },
  ["niI"] = { "通常 i", "Normal" },
  ["niR"] = { "通常 r", "Normal" },
  ["niV"] = { "通常 v", "Normal" },
  ["nt"] = { "N端末", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },

  ["v"] = { "視覚", "Visual" },
  ["vs"] = { "視覚-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "視覚-LINE", "Visual" },
  ["Vs"] = { "視覚-LINE", "Visual" },
  [""] = { "視覚-BLOCK", "Visual" },

  ["i"] = { "入力", "Insert" },
  ["ic"] = { "入力 (completion)", "Insert" },
  ["ix"] = { "入力 completion", "Insert" },

  ["t"] = { "端末", "Terminal" },

  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },

  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [""] = { "S-BLOCK", "Select" },
  ["c"] = { "コマンド", "Command" },
  ["cv"] = { "コマンド", "Command" },
  ["ce"] = { "コマンド", "Command" },
  ["cr"] = { "コマンド", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}
M = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = {
      btns = function()
        local appname = vim.env.NVIM_APPNAME:gsub("nvim", ""):gsub("%-", "")
        if appname == "" then
          return ""
        end
        local btn = require("nvchad.tabufline.utils").btn
        local toggle_theme = btn(appname, "ThemeToggleBtn", "Toggle_theme")
        return toggle_theme
      end,
    },
  },
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    order = { "mode", "file", "git", "%=", "lsp_msg", "diagnostics", "%=", "cwd", "lsp", "cursor", "copilot" },
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    modules = {
      mode = function()
        local utils = require "nvchad.stl.utils"
        if not utils.is_activewin() then
          return ""
        end

        local m = vim.api.nvim_get_mode().mode
        local current_mode = "%#St_" .. modes[m][2] .. "Mode# " .. modes[m][1]
        local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
        -- local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. modes[m][1]
        return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
      end,
      lsp = function()
        local utils = require "nvchad.stl.utils"
        if rawget(vim, "lsp") and vim.version().minor >= 10 then
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[utils.stbufnr()] and client.name ~= "copilot" then
              -- return (vim.o.columns > 100 and "%#st_lspicon#▍ ▐%#st_lsp#" .. client.name .. " ")
              return (vim.o.columns > 100 and "%#st_lsp#" .. client.name .. " /")
                or "%#st_lspicon#▍ ▐"
            end
          end
        end
        return ""
      end,
      cwd = function()
        local icon = "%#St_cwd_text#" .. "󰉋"
        local name = vim.uv.cwd()
        name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
        return (vim.o.columns > 85 and ("%#St_cwd_sep# " .. icon .. name) .. "/ ") or ""
      end,
      cursor = function()
        return "%#St_pos_icon#" .. "%#St_Pos_text# %p%% "
      end,
      copilot = function()
        local utils = require "nvchad.stl.utils"
        if rawget(vim, "lsp") and vim.version().minor >= 10 then
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[utils.stbufnr()] and client.name == "copilot" then
              local c = require "copilot.client"
              return (c.is_disabled()) and "" or "%#St_CopilotSep# %#St_Copilot#  %#St_CopilotSep#▌"
            end
          end
        end
        return ""
      end,
    },
  },
}
return M
