require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del


map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ";", ":", { desc = "Enter command mode", nowait = true })

-- navigation mappings
map("i", "<C-Left>", "<cmd>tabn<CR>", { desc = "Next tab" })
map("i", "<C-Right>", "<cmd>tabp<CR>", { desc = "Previous tab" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line down" })
map("n", "<leader>wo", "<cmd> Telescope workspaces <CR>", { desc = "Open workspace" })
map("n", "j", "gj")
map("n", "k", "gk")

-- editing mappings
map("n", "E", "$", { desc = "Goto end of line", remap = true })
map({"n", "v", "i"}, "<C-Left>", ":tabn<cr>", { desc = "Next tab" })
map({"n", "v", "i"}, "<C-Right>", ":tabp<cr>", { desc = "Previous tab" })

-- move line down/up
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line down" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .-2<CR>==gi", { desc = "move line down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line up" })

-- copy line down/up
map("v", "<A-S-j>", ":co '><CR>V'[=gv", { desc = "copy line down" })
map("v", "<A-S-k>", ":co '><CR>Vgv=gv", { desc = "copy line up" })
map("n", "<A-S-k>", ":t .-1<CR>==", { desc = "Copy line down" })
map("n", "<A-S-j>", ":t .<CR>==", { desc = "Copy line up" })

-- other mappings 
map("n", "<leader>th", "<cmd>lua require('base46').toggle_theme()<cr>", { desc = "Toggle theme" })

--- remove default mappings 
unmap("n", "<leader>wk")
unmap("n", "<leader>wK")
