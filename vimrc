set nocompatible  " Close the compatibility between vim and vi
filetype off      " required

"##########################################################
" Vundle plugins
" set the runtime path to inclued Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'             " Let Vundle manage Vundle, required

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" Global
Plugin 'tpope/vim-fugitive'            " Git interface
Plugin 'tmhedberg/SimpylFold'          " Code floding plugin
Plugin 'Valloric/YouCompleteMe'        " Auto completed
Plugin 'scrooloose/syntastic'          " Syntax checker
Plugin 'jistr/vim-nerdtree-tabs'       " File System by tab
Plugin 'scrooloose/nerdtree'           " File System
Plugin 'kien/ctrlp.vim'                " File System super index search

" Python
Plugin 'vim-scripts/indentpython.vim'  " Auto indent plugin
"Plugin 'vim-scripts/Pydiction'         " Key word autocomplete
Plugin 'nvie/vim-flake8'               " PEP8 sytax style check

" Html

call vundle#end()

filetype plugin indent on  " Enables filetype detection

"##########################################################
"Basic
syntax enable
set number  "Turn row number on
set ruler  "Turn coordinate on
set smartcase  "Turn smart uper lower case search on
set hlsearch  "Make the search string with highlight
set showcmd  "Show command prompt of vim
set showmode "Show operation mode of vim
" Set which mode can use mouse to operate; `n` normal, `v` visual, 
" `i` insert, `c` command, `a` all
set mouse=

"##########################################################
" Color
set t_Co=256 "Make vim support 256 colors
colo torte   "Set IDE color scheme, you can find others in ~/.vim/colors/
set cursorline  "Show the row of cursor, use `nocursor` to turn off
set cursorcolumn  "Show the column of cursor, use `nocursor` to turn off
" Use `heighlight` or `hi` to adjust heighlight style
" `cterm` be used to adjust style of char; `none` means maintain,
" `underline`, `bold`, `reverse`.
" `ctermbg` be used to adjust background color.
" `ctermfg` be used to adjust front color.
" ** `heighlight` or `hi` need to locate behide `colorscheme`
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi CursorColumn cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=none
hi BadWhitespace ctermbg=red guibg=red

"###########################################################
" Status line
set laststatus=2  "Turn status line of vim on
" Use statusline to set format
" `%t` means file name
" `%F` means file path
" `%y` means file type
" `%=` separation of left and right
" `%c` means column location of cursor now
" `%l` means row location of cursor now
" `%L` means number of total row
" `%p` means percentage of browsing
set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
hi filepath cterm=none ctermbg=238 ctermfg=40
hi filetype cterm=none ctermbg=238 ctermfg=45
hi filesize cterm=none ctermbg=238 ctermfg=225
hi position cterm=none ctermbg=238 ctermfg=228

function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction

function FileSize()
    let bytes = getfsize(expand("%:p:"))
    if bytes <= 0
        return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction

"###########################################################
" Encode
set encoding=utf-8
if has("multi_byte")
    set fileencodings=utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1
else
    echoerr "If +multi_byte is not included, you should compile Vim with big features."
endif

"###########################################################
" Custom hot key

" `map`, `nmap`, `vmap`, `omap`, `map!`, `imap`, `cmap` can make hot key
" `map` include normal and visual mode
" `map!` include what `map` not inculde
" `imap` include insert mode
" `cmap` include command mode

" Custom keys for autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"###########################################################
" Split Layouts
set splitbelow
set splitright

" Set hotkey for layer windows transfer
" To below window
nnoremap <C-J> <C-W><C-J>
" To top window
nnoremap <C-K> <C-W><C-K>
" To right window
nnoremap <C-L> <C-W><C-L>
" To left window
nnoremap <C-H> <C-W><C-H>

"###########################################################
" Code Folding
set foldmethod=indent
set foldlevel=99
let g:SimpyFold_docstring_preview=1

" Folding based on indentation
autocmd FileType python set foldmethod=indent

" Enable folding with the spacebar
nnoremap <space> za

"###########################################################
" File System

" Ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$']

" Fix Nerd Tree's odd behavior
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = '1'

"###########################################################
" Python Style PEP8
au BufNewFile,BufRead *.py
   \ set tabstop=4 |
   \ set softtabstop=4 |
   \ set shiftwidth=4 |
   \ set textwidth=79 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Tag redundent space char 
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/

" Automate adding Shebang
augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$      
augroup END

" Keep indentation level from previous line
autocmd FileType python set autoindent

" Python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF

"###########################################################
" Front end Style
au BufNewFile,BufRead *.js, *html, *css
   \ set tabstop=2 | 
   \ set softtabstop=2 |
   \ set shiftwidth=2 
