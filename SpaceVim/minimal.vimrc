set nocompatible

let script_dir = fnamemodify(expand('<sfile>'), ':h')
let &runtimepath .= ','.script_dir.','.script_dir.'/after'

" Put your config changes here.
" let g:jedi#show_call_signatures=1

syntax on
filetype plugin indent on