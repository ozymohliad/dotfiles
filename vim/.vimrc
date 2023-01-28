" Dependencies:
" Plug
" nerdtree 
" vim-airline
" vim-airline-themes
" vim-gruvbox theme
" powerline fonts

" source /usr/share/vim/vim82/defaults.vim


" Plugins ---------- {{{
" call plug#begin()
" Plug 'vim-airline/vim-airline'
" Plug 'preservim/nerdtree'
" Plug 'dag/vim-fish'
" call plug#end()
" }}}
" Basic settings ---------- {{{
set runtimepath+=/usr/share/vim/vim81
set nohlsearch
set clipboard=unnamedplus
set tabstop=4
set shiftwidth=0
set expandtab
set number
set termguicolors
set spelllang=en
set timeoutlen=200
set mouse=niv
set iskeyword+=-
" }}}
" Mappings ---------- {{{
let mapleader = "\<bs>"

" leave insert mode with 'jk'
inoremap jk <esc>

"" quote word/selection
nnoremap <leader>" mcviw<esc>a"<esc>bi"<esc>`cl
nnoremap <leader>' mcviw<esc>a'<esc>bi'<esc>`cl
vnoremap <leader>" mc<esc>`>a"<esc>`<i"<esc>`cl
vnoremap <leader>' mc<esc>`>a'<esc>`<i'<esc>`cl

"" Sort paragraph
noremap <leader>s vip:sort<CR>

"" Scroll
nnoremap <C-j> 2<C-e>
nnoremap <C-k> 2<C-y>

"" Move in visual lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

"" Split shortcuts
noremap sj <C-W>j
noremap sk <C-W>k
noremap sh <C-W>h
noremap sl <C-W>l
noremap SK :res +5<CR>
noremap SJ :res -5<CR>
noremap SL :vertical resize +5<CR>
noremap SH :vertical resize -5<CR>

"" Tab shortcuts
noremap tl :tabnext<CR>
noremap th :tabprev<CR>
noremap tt :tabnew<space>
noremap td :tabclose<CR>
noremap <C-t>h :tabm -1<CR>
noremap <C-t>l :tabm +1<CR>
noremap t] <c-w>]<c-w>T<CR> 

"" Buffer navigation
noremap <leader>] :next<CR>
noremap <leader>[ :prev<CR>

" theme control
noremap <expr> <F5> &background == "dark" ? ':set background=light<CR>':':set background=dark<CR>'

" Toggle [relative] number
noremap <leader>N :set number!<CR>
noremap <leader>n :set relativenumber!<CR>

" Toggle spell
nnoremap <leader>S :set spell!<CR>

" Toggle search highlighting
nnoremap <leader>h :set hlsearch!<CR>

" FZF
nnoremap ff :FZF<CR>
nnoremap fgf :GFiles<CR>
nnoremap fsf :GFiles?<CR>
nnoremap fbf :Buffers<CR>
nnoremap faf :Ag<CR>

" Quick vimrc editing
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" }}}
" Filetype-specific settings ---------- {{{
augroup vim_filetype
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

func Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc

augroup c_filetype
	autocmd!
	autocmd FileType c iabbrev <buffer> if if ()<left><C-R>=Eatchar('\s')<CR>
augroup END
" }}}
" Theme ---------- {{{
" Airline
let g:airline_theme='zenburn'
let g:airline_powerline_fonts = 1

" Color scheme
if $THEME == "dark"
    set background=dark
end

if $THEME == "light"
    set background=light
end

let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox
" }}}
" Neovide ---------- {{{
	set guifont=Hack:h15
" }}}
