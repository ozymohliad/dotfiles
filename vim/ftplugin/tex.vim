setlocal textwidth=100

function EnvironAbbrev(a, e)
	execute "iabbrev <buffer> ".a:a." \\begin{".a:e."}<CR>\\end{".a:e."}<ESC>O"
endfunction

call EnvironAbbrev("bcenter", "center")
call EnvironAbbrev("benum", "enumerate")
call EnvironAbbrev("bitem", "itemize")
call EnvironAbbrev("btable", "table")
call EnvironAbbrev("bfig", "figure")
call EnvironAbbrev("btab", "tabular")
call EnvironAbbrev("beq", "equation")
call EnvironAbbrev("benv", "<++>")

command W w | !cd $(dirname %) && lualatex --shell-escape $(basename %)

nnoremap <buffer> <leader>re :.-1,.+1s/<++>/

iabbrev <buffer> bbold {\bfseries}<Left>
iabbrev <buffer> bemph \emph{}<Left>
iabbrev <buffer> bcode {\ttfamily}<Left>

onoremap <buffer> iq :<C-u>normal! t'vT`<CR>
onoremap <buffer> aq :<C-u>normal! f'llF'vF`hhf`<CR>

vnoremap <buffer> <leader>b c\bold{}<esc>P
vnoremap <buffer> <leader>e c\emph{}<esc>P
