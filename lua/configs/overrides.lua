local M = {}
local separators = {
  default = { left = "", right = "" },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}
local sep_l = separators["default"]["left"]
local sep_r = separators["default"]["right"]
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
  syntax = true, -- enable syntax highlighting, affects performance
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
    "java",
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
  local select_one_or_multi = function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
      require("telescope.actions").close(prompt_bufnr)
      for _, j in pairs(multi) do
        if j.path ~= nil then
          vim.cmd(string.format("%s %s", "edit", j.path))
        end
      end
    else
      require("telescope.actions").select_default(prompt_bufnr)
    end
  end
  require("telescope").setup {
    extensions = {
      file_browser = {
        layout_config = { height = 0.4 },
        hijack_netrw = true,
        grouped = true,
        select_buffer = true,
        hide_parent_dir = true,
        quiet = true,
        dir_icon = "󰉋",
        dir_icon_hl = "@function",
        display_stat = {},
        git_status = true,
        respect_gitignore = true,
        prompt_path = true,
        hidden = false,
        mappings = {
          ["i"] = {
            ["<C-a>"] = fb.create,
            ["<C-e>"] = fb.rename,
            ["<C-x>"] = fb.move,
            ["<C-l>"] = select_one_or_multi,
            ["<C-h>"] = fb.goto_parent_dir,
            ["<C-g>"] = fb.toggle_respect_gitignore,
            ["<C-.>"] = fb.toggle_hidden,
          },
          ["n"] = {
            a = fb.create,
            e = fb.rename,
            x = fb.move,
            l = select_one_or_multi,
            h = fb.goto_parent_dir,
            c = fb.copy,
            g = fb.toggle_respect_gitignore,
            ["."] = fb.toggle_hidden,
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
