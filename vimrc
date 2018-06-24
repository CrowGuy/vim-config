"Vundle
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required

" Add all your plugins here (note older versions of Vundle used Bundle 
" instead of Plugin)

"Python
Plugin 'nvie/vim-flake8'               " PEP8 coding style check
Plugin 'vim-scripts/Pydiction'         " key word autocomplete
Plugin 'vim-scripts/indentpython.vim'  " Indent plugin

"Code folding
Plugin 'tmhedberg/SimpylFold'          " Code floding plugin

"Auto completion stuff
Plugin 'Valloric/YouCompleteMe'        " Auto completed

"Syntax checker
Plugin 'scrooloose/syntastic'

"File system
Plugin 'jistr/vim-nerdtree-tabs'

"Colors!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Show docstring of code folding
let g:SimpylFold_docstring_preview=1

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"---------------------Begin global config-------------------
" Set the default file encoding to UTF-8
set encoding=utf-8

" Enable code line number
"set nu

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Fix Nerd Tree's odd behavior
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = '1'

" Ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$']

"----------------------End global config--------------------

"----------------Begin python develop IDE config------------
" Python PEP 8 stuff
" Number of space that a pre-exiting tab is equal to.
au BufNewFile,BufRead *.py set tabstop=4

" Spaces for indents
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set softtabstop=4

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=79

" Use UNIX (\n) line endings.
au BufNewFile *.py set fileformat=unix

" Keep indentation level from previous line:
autocmd FileType python set autoindent

"Folding based on indentation:
autocmd FileType python set foldmethod=indent
"use space to open folds
nnoremap <space> za

" Python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
"----------------End python develop IDE config--------------
