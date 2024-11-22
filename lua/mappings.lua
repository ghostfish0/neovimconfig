require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ";", ":", { desc = "Enter command mode", nowait = true })

-- navigation mappings
map("n", "<leader>wo", "<cmd> Telescope workspaces <CR>", { desc = "Open workspace" })
map("n", "j", "gj")
map("n", "k", "gk")
map({ "n", "v" }, "]]", "]m")
map({ "n", "v" }, "[[", "[m")

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

map("n", "<A-->", "<C-w><", { desc = "" })
map("n", "<A-=>", "<C-w>>", { desc = "" })

map("n", "dac", "V%d", { desc = "Delete comment" })

-- other mappings
map("n", "<leader>th", "<cmd>lua require('base46').toggle_theme()<cr>", { desc = "Toggle theme" })

-- terminal mappings
-- map({ "n" }, "<leader>v", function()
--   require("nvchad.term").toggle { cmd = "cmd /k", pos = "vsp", id = "vtoggleTerm", size = 0.3 }
-- end, { desc = "Terminal Toggleable vertical term" })
--
-- map({ "n" }, "<leader>h", function()
--   print "hello"
--   require("nvchad.term").toggle { cmd = "cmd /k", pos = "sp", id = "htoggleTerm", size = 0.3 }
-- end, { desc = "Terminal New horizontal term" })

map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal go up" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal go left" })
map("t", "<C-n>", "<C-\\><C-n>", { desc = "Exit terminal mode", nowait = true })
map("t", "<Esc>", function() -- workaround for normal-terminal mode
    vim.cmd "q"
end, { desc = "Close terminal" })

--- remove default mappings
-- unmap({ "n", "t" }, "<A-h>")
-- unmap({ "n", "t" }, "<A-v>")
unmap("n", "<C-n>")
unmap("n", "<leader>wk")
unmap("n", "<leader>wK")
unmap("n", "<leader>e")

--- redefine default mappings
map("n", "<leader>e", "<cmd>Telescope file_browser<cr>")
map("n", "<space>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
