require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ";", ":", { desc = "Enter command mode", nowait = true })


-- navigation mappings
map("n", "<leader>wo", "<cmd> Telescope workspaces <CR>", { desc = "Open workspace" })
map("n", "j", "gj")
map("n", "k", "gk")

-- editing mappings
map({ "n", "v", "i" }, "<C-Left>", "<cmd>tabn<cr>", { desc = "Next tab" })
map({ "n", "v", "i" }, "<C-Right>", "<cmd>tabp<cr>", { desc = "Previous tab" })

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
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTree Toggle window" })

-- terminal mappings
map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
end, { desc = "Terminal Toggleable vertical term" })

map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "Terminal New horizontal term" })

-- spider
map({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
map({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
map({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

--- remove default mappings
unmap({ "n", "t" }, "<A-h>")
unmap({ "n", "t" }, "<A-v>")
unmap("n", "<C-n>")
unmap("n", "<leader>wk")
unmap("n", "<leader>wK")
unmap("n", "<leader>e")

--- redefine default mappings
map("n", "<leader>e", "<cmd>Telescope file_browser<cr>")
