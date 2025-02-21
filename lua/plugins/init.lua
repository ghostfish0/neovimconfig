local overrides = require("configs.overrides")
return {
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = overrides.imgclip,
        cmd = {
            "PasteImage",
            "ImgClipDebug",
            "ImgClipConfig"
        },
    },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup(overrides.blankline)
        end,
    },
    {
        "kiyoon/treesitter-indent-object.nvim",
        keys = {
            {
                "af",
                function()
                    require("treesitter_indent_object.textobj").select_indent_outer(true, "V")
                end,
                mode = { "x", "o" },
                desc = "Select context-aware indent (outer, line-wise)",
            },
            {
                "if",
                function()
                    require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
                end,
                mode = { "x", "o" },
                desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
            },
        },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = overrides.telescopefb,
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false,
    },
    {
        "max397574/better-escape.nvim",
        enabled = false,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        keys = {
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
        "zbirenbaum/copilot.lua",
        cmd = { "Copilot" },
        config = function()
            require("copilot").setup(overrides.copilot)
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "jbyuki/nabla.nvim",
        -- enabled = false,
        keys = {
            { "<leader>P", '<cmd>lua require("nabla").toggle_virt()<CR>', "Peek mathzones" },
            { "<leader>p", '<cmd>lua require("nabla").popup()<CR>',       "Peek mathzones" },
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
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require("configs.conform"),
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            { "rafamadriz/friendly-snippets",     enabled = false },
            { "ghostfish0/friendly-snippets.nvim" },
        },
        opts = {
            enable_autosnippets = true,
        },
        config = function(_, opts)
            require("luasnip").config.set_config(opts)
            require("nvchad.configs.luasnip")
            vim.keymap.set(
                "n",
                "<Leader>L",
                '<Cmd>lua   require("luasnip.loaders.from_lua").lazy_load({paths = "./lua/snippetsmath"}) require("luasnip.loaders.from_vscode").lazy_load()  print "Math snippets loaded 👍"<CR>'
            )
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = overrides.cmp,
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup({})
                end,
            },
        },
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig")
        end,
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
    { "nvzone/volt",  enabled = false },
    { "nvzone/menu",  enabled = false },
    { "nvzone/minty", enabled = false },
    {
        "folke/which-key.nvim",
        enabled = false,
    },
}
