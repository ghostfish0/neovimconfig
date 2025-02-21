require "nvchad.options"

local o = vim.o
local g = vim.g
local api = vim.api
-- linebreaking and make sure linebreak follows indent
local new_cmd = api.nvim_create_user_command
o.linebreak = true
o.breakindent = true
o.number = false
o.shiftwidth = 2
o.tabstop = 2
o.fileformat = "unix"
-- o.number = false

g.vimtex_imaps_enabled = 0

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
g.matchup_matchparen_offscreen = 'popup'

vim.cmd [[ 
    augroup matchup_matchparen_disable_ft
      autocmd!
      autocmd FileType lazy,help let [b:matchup_matchparen_fallback,
          \ b:matchup_matchparen_enabled] = [0, 0]
    augroup END
]]


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

-- lua snippets
require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets/" })
