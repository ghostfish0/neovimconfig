local overrides = require "configs.overrides"
return {
  {"seandewar/killersheep.nvim", cmd = "KillKillKill"},
  {"seandewar/nvimesweeper", cmd = "Nvimesweeper"},
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = overrides.telescopefb,
  },
  {
    "ms-jpq/chadtree",
    branch = "chad",
    build = "python3 -m chadtree deps",
    lazy = false,
    enabled = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  -- {
  --   "chrisgrieser/nvim-spider",
  --   lazy = true, -- set in mappings.lua
  -- },
  {
    "ghostfish0/vim-matchup",
    -- enabled = false,
    event = "User FilePost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "xeluxee/competitest.nvim",
    cmd = "CompetiTest",
    dependencies = "MunifTanjim/nui.nvim",
    -- lazy load via workspace.nvim's hooks
    lazy = true,
    config = function()
      require("competitest").setup(overrides.competitest)
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    keys = {
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      { ",,", "<cmd>CopilotChatToggle<cr>", mode = { "n", "v" }, desc = "CopilotChat - Toggle" },
    },
    cmd = { "CopilotChat", "CopilotChatToggle" },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = overrides.copilotchat,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  {
    "jbyuki/venn.nvim",
    enabled = false,
    cmd = "VBox",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User FilePost",
    config = function()
      require("treesitter-context").setup(overrides.context)
    end,
  },
  {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
  },
  {
    "mg979/vim-visual-multi",
    enabled = false,
    branch = "master",
    lazy = false,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    config = function()
      require("copilot").setup(overrides.copilot)
    end,
  },
  {
    "saimo/peek.nvim",
    -- enabled = false,
    build = "deno task --quiet build:fast",
    cmd = { "Peek" },
    config = function()
      require("peek").setup(overrides.peek)
    end,
  },
  {
    "jbyuki/nabla.nvim",
    -- enabled = false,
    keys = {
      { "<leader>P", '<cmd>lua require("nabla").toggle_virt()<CR>', "Peek mathzones" },
      { "<leader>p", '<cmd>lua require("nabla").popup()<CR>', "Peek mathzones" },
    },
  },
  {
    "stevearc/aerial.nvim",
    -- enabled = false,
    keys = { { "<leader>a", "<cmd>AerialToggle!<CR>" } },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup(overrides.aerial)
    end,
  },
  {
    "natecraddock/workspaces.nvim",
    config = function()
      require("workspaces").setup(overrides.workspaces)
    end,
  },
  -- override plugin configs with setup function
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup(overrides.blankline)
      -- vim.cmd.highlight('clear @ibl.scope.underline.1')
      -- vim.cmd.highlight('link @ibl.scope.underline.1 IndentBlanklineContextStart')
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      { "rafamadriz/friendly-snippets", enabled = false },
      { "ghostfish0/friendly-snippets.nvim" },
    },
    opts = {
      enable_autosnippets = true,
    },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"
      vim.keymap.set(
        "n",
        "<Leader>L",
        '<Cmd>lua   require("luasnip.loaders.from_lua").lazy_load({paths = "./lua/snippetsmath"}) require("luasnip.loaders.from_vscode").lazy_load()  print "Math snippets loaded 👍"<CR>'
      )
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup {}
        end,
      },
    },
    config = function(_, opts)
      require("cmp").setup(opts)
      require("cmp").setup.filetype("cpp", overrides.cmpcpp)
    end,
  },
  -- override plugin configs
  {
    "NvChad/nvim-colorizer.lua",
    opts = overrides.colorizer,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  -- disabled plugins
  {
    "folke/which-key.nvim",
    enabled = false,
  },
}
