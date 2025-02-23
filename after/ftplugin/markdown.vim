call vimtex#options#init()
call vimtex#text_obj#init_buffer()

nmap <silent><buffer> dsc <plug>(vimtex-cmd-delete)

nmap <silent><buffer> csc <plug>(vimtex-cmd-change)
nmap <silent><buffer> csd <plug>(vimtex-delim-change-math)
nmap <silent><buffer> cse <plug>(vimtex-env-change)

nmap <silent><buffer> tsb <plug>(vimtex-env-toggle-break)
nmap <silent><buffer> tsm <plug>(vimtex-env-toggle-math)

nmap <silent><buffer> <F6> <plug>(vimtex-env-surround-line)
nmap <silent><buffer> <F6> <plug>(vimtex-env-surround-operartor)
xmap <silent><buffer> <F6> <plug>(vimtex-env-surround-visual)

imap <silent><buffer> ]] <plug>(vimtex-delim-close)

omap <silent><buffer> id <plug>(vimtex-id)
omap <silent><buffer> ad <plug>(vimtex-ad)
xmap <silent><buffer> id <plug>(vimtex-id)
xmap <silent><buffer> ad <plug>(vimtex-ad)

nmap <silent><buffer> % <plug>(vimtex-%)
xmap <silent><buffer> % <plug>(vimtex-%)
omap <silent><buffer> % <plug>(vimtex-%)

" ... (add more maps if you want)

