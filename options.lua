require "nvchad.options"

local opt = vim.o
local api = vim.api
-- linebreaking and make sure linebreak follows indent
local new_cmd = api.nvim_create_user_command
opt.linebreak = true
opt.breakindent = true
opt.cursorline = false

vim.cmd [[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell -NoLogo'
		let &shellcmdflag = '-Command'
		let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
		set shellquote= shellxquote=
]]

new_cmd("Time", 'echo strftime("%F %X")', {})
new_cmd("Todo", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/i-passi-della-conquista-del-mondo.md", {})
new_cmd("Codethings", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/code.md", {})
new_cmd("Calendar", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/calendario.md", {})
new_cmd("WhereAmI", ':lua print(vim.fn.expand("%:p"))', {})
new_cmd("NablaToggle", 'lua require("nabla").toggle_virt()', {})

-- lua snippets
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "\\lua\\snippets"
---
