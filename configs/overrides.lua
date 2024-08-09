local M = {}

M.competitest = {
  runner_ui = {
    interface = "split",
  },
  compile_command = { cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } } },
  testcases_directory = "./testcases",
}

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
  matchup = {
    enable = true,
    disable = { "c", "ruby", "help" },
    disable_virtual_text = true,
  },
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
  extensions = {
    file_browser = {
      initial_mode = "normal",
      hijack_netrw = true,
    },
  },
}

M.telescopefb = function()
  require("telescope").load_extension "file_browser"
  local fb = require("telescope").extensions.file_browser.actions
  require("telescope").setup {
    extensions = {
      file_browser = {
        layout_config = { height = 0.4 },
        theme = "ivy",
        hijack_netrw = true,
        grouped = true,
        select_buffer = true,
        hide_parent_dir = true,
        quiet = true,
        dir_icon = "󰉋",
        dir_icon_hl = "@function",
        display_stat = {},
        git_status = true,
        prompt_path = true,
        mappings = {
          ["i"] = {
            ["<C-a>"] = fb.create,
            ["<C-e>"] = fb.rename,
            ["<C-x>"] = fb.move,
            ["<C-l>"] = require("telescope.actions").select_default,
            ["<C-h>"] = fb.goto_parent_dir,
          },
          ["n"] = {
            a = fb.create,
            e = fb.rename,
            x = fb.move,
            l = require("telescope.actions").select_default,
            h = fb.goto_parent_dir,
          },
        },
      },
    },
  }
end

M.workspaces = {
  cd_type = "tab",
  hooks = {
    open = function(name, _)
      if name == "cp" then
        require("competitest").setup()
        return false
      end
    end,
  },
}

-- git support and more in nvimtree
M.nvimtree = {
  hijack_cursor = false,
  view = {
    cursorline = false,
    width = {
      max = "25%",
    },
  },
  actions = {
    open_file = {
      resize_window = false,
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
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "copilot" },
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
    modules = {
      mode = function()
        local utils = require "nvchad.stl.utils"
        if not utils.is_activewin() then
          return ""
        end

        local modes = utils.modes

        local m = vim.api.nvim_get_mode().mode

        local current_mode = "%#St_" .. modes[m][2] .. "Mode# " .. modes[m][1] .. " "

        return current_mode
      end,
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
    },
  },
}

local cmp = require "cmp"
M.cmp = {
  sources = {
    { name = "luasnip" },
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}

M.cmpcpp = {
  sources = {
    { name = "luasnip", priority = "1000000" },
    { name = "buffer" },
    { name = "path" },
  },
}

return M
