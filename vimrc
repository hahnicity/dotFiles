""""""Vundle INITIALIZATION"""""""""""""""""
set nocompatible
filetype off

""""BUNDLES"""""""
" Set vundle in runtimepath.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Call vundle with path to bundles. Default, only check .vim dir.

Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'BusyBee'
Plugin 'Vundle.vim'
" Requires package ack-grep
Bundle 'mileszs/ack.vim'
Bundle 'rosenfeld/conque-term'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'bling/vim-airline'
Bundle 'SuperTab'
Bundle 'Shougo/neocomplete.vim'
Bundle 'go.vim'
Bundle 'octave.vim'
Bundle 'tpope/vim-rsi'
Bundle 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end()

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
let tmpDir="~/.tmpVim"
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
colorscheme BusyBee

let g:solarized_termcolors=16
set background=dark
" If using Terminator, this depends on https://github.com/ghuntley/terminator-solarized
"colorscheme solarized

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

""""" NEOCOMPLETE""""
let g:neocomplete#enable_cursor_hold_i = 1
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_prefetch = 1
let g:neocomplete#data_directory = tmpDir . "/neocomplete"
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : ''
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

""""""""""""""""" vim-markdown """""""""""""""""""
let g:vim_markdown_folding_disabled=1
