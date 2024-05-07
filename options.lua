require "nvchad.options"

local opt = vim.o
local api = vim.api
-- linebreaking and make sure linebreak follows indent
local new_cmd = api.nvim_create_user_command
opt.linebreak = true
opt.breakindent = true
opt.cursorline = false

new_cmd("Time", 'echo strftime("%F %X")', {})
new_cmd("Todo", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/i-passi-della-conquista-del-mondo.md", {})
new_cmd("Calendar", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/calendario.md", {})
new_cmd("WhereAmI", ':lua print(vim.fn.expand("%:p"))', {})
new_cmd("NablaToggle", 'lua require("nabla").toggle_virt()', {})
new_cmd("Lazygit", 'lua require("nvchad.term").toggle { pos = "vsp", id = "lazygit", cmd=\'lazygit\' }', {})

-- lua snippets
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "\\lua\\snippets"
---

-- Autoclose preview window after completion in Latex
api.nvim_create_autocmd("CompleteDone", { command = "pclose" })
api.nvim_create_autocmd("BufWinEnter", { pattern = "*.{markdown,md}", command = "set nonu" })
api.nvim_create_autocmd("BufWinLeave", { pattern = "*.{markdown,md}", command = "set nu" })
api.nvim_create_autocmd("TermClose", {
  callback = function()
    if vim.v.event.status == 0 then
      vim.cmd "bd!"
    end
  end,
})
