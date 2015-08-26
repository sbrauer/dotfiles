execute pathogen#infect()

set nocompatible
set fileformat=unix
set encoding=utf8
set expandtab
set visualbell
set incsearch
set hlsearch
set autoindent
set autochdir
set showmatch
set ruler
set cursorline
set number
set showmode
set showcmd
set mouse=a   " enable mouse in terminal vim

silent execute '!mkdir -p $HOME/.vim-tmp/backup'
silent execute '!mkdir -p $HOME/.vim-tmp/swap'
set backupdir=~/.vim-tmp/backup//
set directory=~/.vim-tmp/swap//

"set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')
set shortmess=atT

set wildmenu
"set wildmode=list:longest,full
set wildmode=longest:full,full

" Don't search include files when autocompleting
" http://stackoverflow.com/a/2460593
set complete=.,w,b,u,t

syntax on
filetype plugin on
filetype indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
autocmd FileType python set tabstop=4|set softtabstop=4|set shiftwidth=4
" Treat ".md" files as Markdown (by default they are considered Modula-2).
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Enable matching for Ruby syntax (with % key).
runtime macros/matchit.vim

" abbreviations (thanks Zander); type the abbr pattern followed by ; and it
" will expand
iabbr _pry require 'pry'; binding.pry
iabbr _pryr require 'pry-remote'; binding.pry_remote
" python-style
iabbr _pdb import pdb; pdb.set_trace()

" map Backspace key to dismiss search highlights
noremap <bs> :noh<CR>

" Exit!
noremap <Leader>x :qall!<CR>

" cycle thru buffers
noremap <Leader>[ :bp!<CR>
noremap <Leader>] :bn!<CR>

noremap <Leader>n :NERDTreeToggle<CR>

" toggle paste
nnoremap <Leader>p :set invpaste paste?<CR>

" toggle line numbers (mnemonic: 3 key has number sign)
noremap <Leader>3 :set invnumber<CR>

" open bufexplorer plugin (shorter than default <Leader>be)
noremap <Leader>e :BufExplorer<CR>

nnoremap <Leader>m :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

" alternative shortcut for vim commentary (default is gc)
xmap <Leader>c <Plug>Commentary
nmap <Leader>c <Plug>Commentary

" Use OSX system clipboard for vim yank, delete, etc. Requires MacVim.
set clipboard=unnamed

" intuitive shortcuts for horizontal and vertical splits
nnoremap <C-w>- :split<enter>
" same key as pipe, but no need to shift
nnoremap <C-w>\ :vsplit<enter>

" override bufexplorer's default 'mru' sort
let g:bufExplorerSortBy='fullpath'

" Highlight whitespace
"set list
"set list listchars=tab:»·,trail:·,eol:¬
set list listchars=tab:»·,trail:·

set laststatus=2          " turn on statusline
" The following was pre-Powerline
"set statusline=%t\        "tail of the filename
"set statusline+=%h        "help file flag
"set statusline+=%m        "modified flag
"set statusline+=%r        "read only flag
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}]   "file format
"set statusline+=%y        "filetype
"set statusline+=%=        "left/right separator
"set statusline+=A:\%b\ H:\x%B " ascii and hex values of current char
"set statusline+=\ %c,       "cursor column
"set statusline+=%l/%L     "cursor line/total lines
"set statusline+=\ %P      "percent through file

" Use space instead of pipe char for vertical splits
" http://stackoverflow.com/questions/9001337/vim-split-bar-styling
" Note that the space at the end of the set line is intentional.
"set fillchars+=vert:\ 

au GUIEnter * set lines=50 columns=80

set t_Co=256
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=0
"let g:solarized_contrast="normal"
colorscheme solarized

let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'solarized16_dark_sam'

" From "Faster Grepping in Vim"
" http://robots.thoughtbot.com/faster-grepping-in-vim

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ag search for the word under cursor, and open quickfix
nnoremap <Leader>a :grep! "\b<C-R><C-W>\b"<CR>:copen<CR><CR>

" git grep for the word under cursor, and open quickfix
nnoremap <Leader>g :Ggrep "<C-R><C-W>"<CR>:copen<CR><CR>

