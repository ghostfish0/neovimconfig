local M = {}

M.context = {
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  separator = "·",
}

M.aerial = {
  backends = {
    markdown = { "markdown" },
    ["_"] = { "treesitter", "lsp" },
  },
  filter_kind = {
    lua = false,
    -- lua = {
    --   -- "String",
    --   "Constructor",
    --   "Enum",
    --   "Function",
    --   "Interface",
    --   "Module",
    --   "Method",
    --   "Struct",
    -- },
    ["_"] = false,
  },
  icons = {
    markdown = { Interface = "" },
    tex = { Method = "" },
  },
  guides = {
    whitespace = " ",
  },
}

M.peek = {
  auto_load = false, -- whether to automatically load preview when entering another markdown buffer
  syntax = false, -- enable syntax highlighting, affects performance
  app = "browser", -- 'webview', 'browser', string or a table of strings explained below
  filetype = { "markdown" }, -- list of filetypes to recognize as markdown
}

M.copilotchat = {
  debug = false,
  question_header = "**>**",
  answer_header = "**<**",
  error_header = "**!!!**",
  separator = " ",

  show_folds = false,
  show_help = false,
  auto_insert_mode = false,

  context = "buffers",
  -- See Configuration section for rest
  -- window = {
  --   layout = "float",
  --   border = "rounded",
  -- },
}

M.copilot = {
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    terminal = false,
    lazy = false,
    mason = false,
    lspinfo = false,
    TelescopePrompt = false,
    TelescopeResults = false,
    nvdash = false,
    nvcheatsheet = false,
    NvimTree = false,
    aerial = false,
    markdown = true,
  },
}

M.treesitter = {
  ensure_installed = {
    "vim",
    -- lua stuff
    "lua",
    -- web dev stuff
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    --- c/cpp stuff
    "c",
    "cpp",
    "cuda",
    -- python stuff
    "python",
    --- note taking stuff
    "markdown",
    "markdown_inline",
    --- graphics stuff
    "glsl",
    ---
    "diff",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
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
  },
}

M.telescope = {
  defaults = {
    -- layout_strategy = "flex",
    layout_config = {},
    border = true,
    preview = {
      filesize_limit = 0.1,
      highligh_limit = 0.1,
      timeout = 100,
    },
  },
  extensions_list = { "themes", "workspaces", "aerial" },
}

M.workspaces = {
  cd_type = "tab",
  hooks = {
    open = function(name, _)
      if name == "cp" then
        require("gitsigns").detach()
        return false
      end
    end,
  },
}

-- git support and more in nvimtree
M.nvimtree = {
  view = {
    cursorline = false,
    width = {
      max = "25%",
    },
  },
  filters = {
    -- git_ignored = false,
  },
  git = {
    disable_for_dirs = {
      "C:\\Users\\tinnguyen\\Documents\\notes\\",
    },
    enable = true,
  },

  renderer = {
    highlight_opened_files = "all",
    -- highlight_git = true,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      show = {
        git = true,
      },
    },
  },
}

-- M.colorizer = {
--   filetypes = {
--     markdown = { names = false },
--     "*", -- Highlight all files, but customize some others.
--   },
-- }

M.blankline = {
  scope = {
    show_start = false,
    show_end = false,
  },
}

M.chadrc = {
  tabufline = {
    lazyload = false,
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
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "cwd", "lsp", "cursor", "copilot" },
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    modules = {
      lsp = function()
        local utils = require "nvchad.stl.utils"
        if rawget(vim, "lsp") and vim.version().minor >= 10 then
          for _, client in ipairs(vim.lsp.get_clients()) do
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
      -- cwd = function()
      --   local file = require("nvchad.stl.utils").file()
      --   local name = vim.loop.cwd()
      --   name = name:match "([^/\\]+)[/\\]*$" or name
      --   return "%#St_cwd_text# " .. file[1] .. " " .. name .. "/" .. file[2] .. " "
      -- end,
    },
    separator_style = "block",
  },
}

M.cmp = {
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip", option = { use_show_condition = true } },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

return M
