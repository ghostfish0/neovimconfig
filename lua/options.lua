require("nvchad.options")

local o = vim.o
local g = vim.g
local api = vim.api
-- linebreaking and make sure linebreak follows indent
local new_cmd = api.nvim_create_user_command
o.linebreak = true
o.breakindent = true
o.number = false
o.shiftwidth = 4
o.tabstop = 4
o.fileformat = "unix"
-- o.number = false

g.loaded_matchparen = 1
g.matchup_matchparen_deferred = 1
g.matchup_matchparen_hi_surround_always = 1
g.matchup_motion_override_Npercent = 0
g.matchup_matchparen_timeout = 200
g.matchup_matchparen_insert_timeout = 60
g.matchup_delim_noskips = 2
g.matchup_matchparen_stopline = 50
g.matchup_matchparen_offscreen = {}
g.matchup_surround_enabled = 1
g.matchup_motion_enabled = 0
g.matchup_matchparen_fallback = 0
g.matchup_matchparen_offscreen = "popup"

vim.cmd([[ 
    augroup matchup_matchparen_disable_ft
      autocmd!
      autocmd FileType lazy,help let [b:matchup_matchparen_fallback,
          \ b:matchup_matchparen_enabled] = [0, 0]
    augroup END
]])

o.shell = "pwsh.exe"
o.shellcmdflag =
	'-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues["Out-File:Encoding"]="utf8";Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
o.shellquote = ""
o.shellxquote = ""

new_cmd("Time", 'echo strftime("%F %X")', {})
new_cmd(
	"Todo",
	":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/markdowns/i-passi-della-conquista-del-mondo.md",
	{}
)
new_cmd("Codethings", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/markdowns/code.md", {})
new_cmd("Calendar", ":e C:/Users/tinnguyen/Documents/Code/Projects/homepage/markdowns/calendario.md", {})
new_cmd("WhereAmI", ':lua print(vim.fn.expand("%:p"))', {})
new_cmd("WhereAmICopy", ':lua vim.fn.setreg("*", vim.fn.expand("%:p:h"))', {})
new_cmd("NablaToggle", 'lua require("nabla").toggle_virt()', {})
new_cmd("Peek", ':lua require("peek").open()<CR>', {})
new_cmd("ToggleTask", function()
	local line = vim.api.nvim_get_current_line()
	if line:match("^%s*%[ %]") then
		-- If it's an unchecked task, mark it as checked
		line = line:gsub("%[ %]", "[x]")
	elseif line:match("^%s*%[x%]") then
		-- If it's a checked task, mark it as unchecked
		line = line:gsub("%[x%]", "[ ]")
	else
		-- If it's not a task, turn it into an unchecked task
		line = "[ ] " .. line
	end
	vim.api.nvim_set_current_line(line)
end, {})

-- lua snippets
require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets/" })
