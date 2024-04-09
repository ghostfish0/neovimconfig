local M = {}

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
      -- See Configuration section for rest
      -- window = {
      --   layout = "float",
      --   border = "rounded",
      -- },
}

M.copilot = {
  suggestion = { enabled = false, },
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
  },
  extensions_list = { "themes", "terms", "workspaces" },
}

-- git support and more in nvimtree
M.nvimtree = {
  view = {
    width = "25%",
  },
  filters = {
    git_ignored = true,
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

M.colorizer = {
  filetypes = {
    "*", -- Highlight all files, but customize some others.
    markdown = { names = false },
  },
}

M.blankline = {
  scope = {
    show_start = false,
    show_end = false,
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
