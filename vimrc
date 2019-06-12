set nocompatible  " Close the compatibility between vim and vi
filetype off      " required

"##########################################################
" Vundle plugins
" set the runtime path to inclued Vundle and initialize
set rtp+=/root/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'             " Let Vundle manage Vundle, required

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" Global
Plugin 'tmhedberg/SimpylFold'          " Code floding plugin
Plugin 'Valloric/YouCompleteMe'        " Auto completed
Plugin 'scrooloose/syntastic'          " Syntax checker
Plugin 'jistr/vim-nerdtree-tabs'       " File System by tab
Plugin 'scrooloose/nerdtree'           " Better file browser
Plugin 'scrooloose/nerdcommenter'      " Code commenter
Plugin 'majutsushi/tagbar'             " Class/module browser
Plugin 'ctrlpvim/ctrlp.vim'            " Code and files fuzzy finder
Plugin 'fisadev/vim-ctrlp-cmdpalette'  " Extension to ctrlp, for fuzzy command
                                       " finder
Plugin 'motemen/git-vim'           " Git integration
Plugin 'mhinz/vim-signify'             " Git/mercurial/others diff icons on
                                       " on the side of the file lines
Plugin 'kien/tabman.vim'               " Tab list pannel
Plugin 'vim-airline/vim-airline'       " Airline
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fisadev/fisa-vim-colorscheme'  " Terminal Vim with 256 colors
                                       " colorscheme
Plugin 'rosenfeld/conque-term'         " Consoles as buffers
Plugin 'fisadev/FixedTaskList.vim'     " Pending tasks list
Plugin 'tpope/vim-surround'            " Surround
Plugin 'Shougo/neocomplcache.vim'      " Better autocompletion
Plugin 'fisadev/dragvisuals.vim'       " Drag visual blocks arround
Plugin 't9md/vim-choosewin'            " Window chooser

" Snippets manager (SnipMate), dependencies, and snippets repo
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'

" Python
Plugin 'vim-scripts/indentpython.vim'  " Auto indent plugin
"Plugin 'vim-scripts/Pydiction'         " Key word autocomplete
Plugin 'nvie/vim-flake8'               " PEP8 sytax style check
Plugin 'davidhalter/jedi-vim'          " Python autocompletion, go to
                                       " definition
Plugin 'fisadev/vim-isort'             " Automatically sort python imports

" Html
Plugin 'mattn/emmet-vim'               " Zen coding
Plugin 'lilydjwg/colorizer'            " Paint css colors with the real checker
Plugin 'vim-scripts/matchit.zip'       " XML/HTML tags navigation

" Markdown


call vundle#end()

filetype plugin indent on  " Allow plugins by file type (required for plugins!)

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

" Code commenter
" auto add a space for comment
let g:NERDSpaceDelims=1

" Tagbar ---------------------
" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus=1  

" NERDTree -------------------
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
map ,t :NERDTreeFind<CR>

" Tasklist -------------------
" show pending tasks list
map <F2> :TaskList<CR>

" Custom keys for autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" CtrlP ----------------------

" file finder mapping
let g:ctrlp_map = ',e'
" tags (symbols) in current file finder mapping
nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :CtrlPBufAll<CR>
" general code finder in all files mapping
nmap ,f :CtrlPLine<CR>
" recent files finder mapping
nmap ,m :CtrPMRUFiles<CR>
" commands finder mapping
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction

" same as previous mappings, but calling with current word as default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" don't change working directory
let g:ctrlp_working_path_mode=0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\.pyc$|\.pyc$',
  \}

" Signify --------------------
" this first setting decides in which order try to guess your current vcs
" Update it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
hi DiffAdd                  cterm=bold ctermbg=none ctermfg=119
hi DiffDelete               cterm=bold ctermbg=none ctermfg=167
hi DiffChange               cterm=bold ctermbg=none ctermfg=227
hi SignifySignAdd           cterm=bold ctermbg=237  ctermfg=119
hi SignifySignDelete        cterm=bold ctermbg=237  ctermfg=167
hi SignifySignChange        cterm=bold ctermbg=237  ctermfg=227

" TabMan ---------------------
" mappings to toggle display, and to focus on it
let g:tabman_toggle='tl'
let g:tabman_focus='tf'

" Airline --------------------
let g:airline_powerline_fonts=0
let g:airline_theme='bubblegum'
let g:airline#extensions#whitespace#enabled=0

" DragVisuals ----------------
" mappings to move blocks in 4 directions
vmap <expr> <S-M-LEFT> DVB_Drag('left')
vmap <expr> <S-M-RIGHT> DVB_Drag('right')
vmap <expr> <S-M-DOWN> DVB_Drag('down')
vmap <expr> <S-M-UP> DVB_Drag('up')
" mapping to duplicate block
vmap <expr> D DVB_Duplicate()

" Syntastic ------------------
" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open=1
" don't put icons on the sign column (it hides the vcs status icons of
" signify
let g:syntastic_enable_signs=0
" coutom icons (enable them if you use a patched font, and enable the previous
" setting)
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'

" Jedi-vim
" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command=',d'
" Find ocurrences
let g:jedi#usages_command=',o'
" Find assignments
let g:jedi#goto_assignments_command=',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Window Chooser
" mapping
nmap - <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable=1

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
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python3\<nl>\"|$
        autocmd BufNewFile *.py 1put =\"# -*- coding: utf-8 -*-\<nl>\"|$
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

"###########################################################
" Markdown


"###########################################################
" Automate adding Shebang
augroup Shebang
	autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
augroup END
