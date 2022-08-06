lua require('plugins')
lua require('lsp')

set shell=/bin/bash

set softtabstop=4
set shiftwidth=4
set textwidth=80
set ts=4
set encoding=utf-8
set cinoptions=:0l1g0t0
" set backup!
set writebackup!
set nu
set et
set nocompatible
set backspace=indent,eol,start
set cin
set cc=80
set t_Co=256
set noeb
set hidden
set vb
set ffs=unix,dos
set mouse=a
set nomodeline

set smartcase

set clipboard+=unnamed " Copy to/paste from system clipboard

" Don't continue comments when pressing o
set fo-=o
set switchbuf+=useopen,usetab

set splitright

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-h> :cd %:h<cr>
nnoremap <SPACE> <Nop>
let mapleader=" "
set showcmd

nnoremap <leader>e :NvimTreeToggle<CR>


augroup filetype
    au BufNewFile,BufRead *.cpp,*.cc,*.cxx,*.C set syntax=cpp11
    au BufNewFile,BufRead *.gplot,*.gp,*.plot,plot setf gnuplot
    au BufNewFile,BufRead *.chords setf chordpro
    au BufNewFile,BufRead *.escript,*.script setf erlang
    au FileType javascript setl sts=2 sw=2
    au FileType lua setl sts=2 sw=2
augroup end

autocmd GUIEnter * set vb t_vb=

let html_use_css=1
let use_xhtml=1
let html_use_numbering=1
let python_highlight_space_error=0
let g:tex_flavor='latex'
let g:proj_flags='imstgcS'
" let c_no_curly_error=1
let pascal_fpc=1

let g:LatexBox_ignore_warnings=['Package cleveref Warning', 'Package eulervm Warning', 'Latex Font Warning']
let g:LatexBox_show_warnings=1

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd SwapExists * let v:swapchoice = "o"

set foldlevelstart=2
set colorcolumn=80

set termguicolors
colorscheme gruvbox-material

syn on
" retab
