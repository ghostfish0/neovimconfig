local M = {}

local bigfilekeys = {
  name = "bigfilekeys",
  opts = { defer = false },
  disable = function()
    -- local map = vim.keymap.set
    local unmap = vim.keymap.del
    unmap("n", "j")
    unmap("n", "k")
  end,
}

M.bigfile = {
  pattern = function(bufnr, _)
    local ft = vim.filetype.match { buf = bufnr }
    -- if vim.bo.filetype == "help" then
    --   print("file is help")
    --   return false
    -- end
    if vim.fn.getfsize(vim.fn.expand "%:p") > 30000 then
      print(ft)
      return true
    end
  end,
  features = { -- features to disable
    "indent_blankline",
    "illuminate",
    "lsp",
    "treesitter",
    "syntax",
    "matchparen",
    "filetype",
    bigfilekeys,
  },
}

M.context = {
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  separator = "·",
}

M.aerial = {
  backends = {
    tex = { "treesitter" },
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
    tex = {
      "Method",
    },
    ["_"] = false,
  },
  icons = {
    markdown = { Interface = "" },
    tex = { Method = "" },
  },
  guides = {
    whitespace = " ",
  },
  -- use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with Shift + '{' and '}'
    if vim.bo.filetype ~= "tex" then
      vim.keymap.set("n", "<C-h>", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<C-l>}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end
  end,
}

M.peek = {
  auto_load = false, -- whether to automatically load preview when entering another markdown buffer
  syntax = false, -- enable syntax highlighting, affects performance
  app = "browser", -- 'webview', 'browser', string or a table of strings explained below
  filetype = { "markdown" }, -- list of filetypes to recognize as markdown
}

M.copilotchat = {
  -- debug = true, -- Enable debugging
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
    "latex",
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
  highlight = {
    disable = function(lang, bufnr)
      -- print(vim.filetype.match({ buf = bufnr }))
      local ft = vim.filetype.match { buf = bufnr }
      if lang == "latex" then
        return ft == nil or ft == "tex"
      end
    end,
    --
    -- additional_vim_regex_highlighting = { "latex", "markdown" },
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
    -- "latexindent",
    "ltex-ls",
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

-- git support and more in nvimtree
M.nvimtree = {
  view = {
    cursorline = false,
    width = {
      max = "25%",
    },
  },
  filters = {
    git_ignored = false,
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
  },
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "cwd", "lsp", "cursor", "copilot" },
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    modules = {
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

M.cmpmarkdown = {
  -- enabled = function()
  --   return require("nabla.utils").in_mathzone() == false
  -- end,
}

M.cmptex = {
  -- nvim-cmp overrides the standard completion-menu formatting. We use
  -- a custom format function to preserve the format as provided by
  -- VimTeX's omni completion function:
  enabled = function()
    return vim.api.nvim_eval "vimtex#syntax#in_mathzone()" ~= 1
  end,
  formatting = {
    format = function(entry, item)
      local cmp_ui = require("core.utils").load_config().ui.cmp
      local cmp_style = cmp_ui.style
      -- print(vim.inspect(entry.source))
      os.execute "echo hello"
      -- print(vim.inspect(entry.source))
      if entry.source.name == "omni" then
        -- local file = io.open("fishy.txt", "w+")
        -- io.output(file)
        -- io.write(vim.inspect(entry.completion_item.textEdit))
        -- io.close(file)
        item.kind = string.match(item.menu, "%[(.*)%]")
        if string.find(item.menu, "cmd") then
          item.kind = item.kind:gsub("cmd:", "")
        else
          item.kind = item.kind:gsub("^%l", string.upper)
        end
        item.menu = item.menu:match "[%]] (.*)"
        -- item.menu = ""
        -- lua print(vim.inspect(entry))
        -- entry.documentation.value = "hello"
      end
      if cmp_style == "atom" or cmp_style == "atom_colored" then
        item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
      else
        item.kind = string.format("%s", cmp_ui.lspkind_text and item.kind or "")
      end

      return item
    end,
  },
  sources = require("cmp").config.sources {
    { name = "omni", trigger_characters = { "{" } },
    { name = "luasnip" },
    { name = "copilot" },
    { name = "buffer" },
  },
}

return M
