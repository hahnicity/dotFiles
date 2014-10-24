""""""Vundle INITIALIZATION"""""""""""""""""
set nocompatible
filetype off

let hostname = substitute(system('hostname'), '\n', '', '')
if hostname=="gregr1"
    " Work machine
    let vimHome="/ext/home/greg.rehm/.vim"
elseif hostname=="gregr"
    " Home machine
    let vimHome="/home/greg/.vim"
elseif hostname=="MinasArnor"
    " Laptop
    let vimHome="/home/greg/.vim"
endif

" Set vundle in runtimepath.
exec 'set rtp+='.vimHome."/bundle/vundle/"

" Call vundle with path to bundles. Default, only check .vim dir.
call vundle#rc(vimHome . "/bundle") 

""""BUNDLES"""""""

Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'BusyBee'
" Requires package ack-grep
Bundle 'mileszs/ack.vim'
Bundle 'rosenfeld/conque-term'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'SuperTab'
Bundle 'go.vim'
Bundle 'octave.vim'

""""OTHER"""""""

" add local, non git, changes.
set rtp+=/usr/local/code/dotvim/local_config/after
set backspace=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cindent                                      " smartindent is deprecated
set mouse=r
set number
set t_Co=256
set encoding=utf-8
set clipboard=unnamed
set noshowmode                                   " required by powerline
set laststatus=2                                 " required by powerline
syntax on

autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
autocmd BufWritePre *.py :%s/\s\+$//e 
autocmd BufWritePre *.py :silent! %s#\($\n\)\+\%$##
autocmd VimResized * wincmd =
retab
filetype indent on
command Q q
command W w
command Wq wq
command WQ wq
command E e
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

"""""""""""""""""""""""""""Syntastic"""""""""""""""""""""""""""""

" E123 - closing bracket does not match indentation of opening bracket's line
" E221 - multiple spaces before operator.  Nice to lineup =.
" E241 - multiple spaces after :.  Nice to lineup dicts. 
" E272 - multiple spaces before keyword.  Nice to lineup import.
" W291 - trailing whitespace. Just annoying"
" W293 - blank line contains whitespace. Just annoying"
" W404 - import *, unable to detected undefined names.
" W801 - redefinition of unused import, try/except import fails.
let g:syntastic_python_flake8_args = "--ignore=E123,E221,E241,E272,W291,W293,W404,W801 --max-line-length=99"
let g:syntastic_python_checkers=["flake8"]
""""""""""""""""""""""Highlight cursor line.""""""""""""""""""""""""""

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorline
  au WinLeave * setlocal nocursorcolumn
augroup END

""""""""""""""""""""""""""Color""""""""""""""""""""""""""""""""""""

syntax enable
"colorscheme BusyBee

let g:solarized_termcolors=16
set background=dark
" If using Terminator, this depends on https://github.com/ghuntley/terminator-solarized
colorscheme solarized

""""""""""""""AIRLINE"""""""""""""""""""""""""""""
let g:airline_powerline_fonts=1
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '◀'
let g:airline_linecolumn_prefix = '¶ '
let g:airline_paste_symbol = 'ρ'
let g:airline_fugitive_prefix = '⎇ '
let g:airline_readonly_symbol = 'RO'
let g:airline_linecolumn_prefix = '¶ '
" replace the fugitive indicator with the current working directory, followed by the filename.
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'

"""""""""""""""""""""" python-mode """"""""""""""""""""""""""""""""
let g:pymode_folding = 0

"""""""""""""""""""""" YCM """"""""""""""""""""""""""""
let g:SuperTabClosePreviewOnPopupClose = 1
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
