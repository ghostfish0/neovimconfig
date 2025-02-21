local M = {}

M.imgclip = {
  extension = "jpg", ---@type string | fun(): string
  relative_to_current_file = true, ---@type boolean | fun(): boolean
  use_cursor_in_template = false,
  insert_mode_after_paste = false,

  show_dir_path_in_prompt = true,
  filetypes = {
    tex = {
      template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.5\textwidth]{assets/$FILE_NAME}
\end{figure}
    ]], ---@type string | fun(context: table): string
    },
  },
}

M.context = {
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  separator = "·",
}

M.aerial = {
  backends = {
    ["_"] = { "treesitter", "lsp" },
  },
  filter_kind = {
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
    "vim",
    -- lua stuff
    "lua",
    -- python stuff
    "python",
    --- note taking stuff
    "diff",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = true,
    disable = { "latex" },
  },
}

M.telescope = {
  defaults = {
    -- layout_strategy = "flex",
    layout_config = {},
    theme = "ivy",
    border = true,
    preview = {
      filesize_limit = 0.1,
      highligh_limit = 0.1,
      timeout = 100,
    },
  },
  extensions_list = { "themes", "workspaces", "aerial" },
  extensions = {
    file_browser = {},
  },
}

M.telescopefb = function()
  require("telescope").load_extension("file_browser")
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
  require("telescope").setup({
    extensions = {
      file_browser = {
        initial_mode = "normal",
        layout_config = { height = 0.4 },
        theme = "ivy",
        hijack_netrw = false,
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
  })
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

M.blankline = {
  scope = {
    show_start = false,
    show_end = false,
  },
}

local cmp = require("cmp")
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

return M
