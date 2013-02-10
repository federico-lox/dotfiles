" == Environment ==

" Use Pathogen to load plugins dynamically,
" management is done using git
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Ensure compatible shell,
" on some machines I use zsh or fish and
" it creates issues at times
set shell=/bin/bash

" Disable Vi legacy support,
" because I like to be Very IMproved ;)
set nocompatible


" == UI ==

" === Colors ===

" Scheme
colorscheme molokai

" Ensure the terminal UI uses the correct palette
if !has("gui_running")
	set  t_Co=256
endif

" Enable syntax coloring
syntax enable

" === Elements ===

" Show line numbers in the gutter
set number

