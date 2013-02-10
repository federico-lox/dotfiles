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

" Enable filetype detection, filetype
" plugins and indent files
filetype plugin indent on


" == UI ==


" === Colors ===

" Scheme
colorscheme molokai

" Ensure the terminal UI uses the correct palette
if !has("gui_running")
	set  t_Co=256
endif


" === Typography ===

" Font
if has("gui_running")
	" Detect the platform and set the font
	" accordingly
	" tip: the Ubuntu Mono font is in the res folder
	if has("win16") || has("win32") || has("win64")
		set guifont=Ubuntu_Mono:h13
	elseif has("unix")
		if has("gui_gtk") || has("gui_gtk2")
			set guifont=Ubuntu\ Mono\ 13
		else
			set guifont=Ubuntu\ Mono:h13
		endif
	endif
endif

" Line spacing
set linespace=3


" === Highlighting ===

" Syntax highlighting
syntax on

" Highlight current line
set cursorline

" Huighliht matching brackets
set showmatch


" === Elements ===

" Show line numbers in the gutter
set number

" Remove unwanted UI elements
if has("gui_running")
	" Remove Toolbar
	set guioptions-=T
	
	" Remove Scrollbars
	set guioptions-=r
	set guioptions-=l
	set guioptions-=b
	set guioptions-=R
	set guioptions-=L
endif


" == Editing ==


" === Input ===

" Backspace works across lines in
" insert mode
set backspace=indent,eol,start

" Tab triggers autocompletion in
" the command line
set wildmenu
set wildmode=list:longest,full

" Enable mouse in terminal UI
set mouse=a

" Hide mouse pointer while typing
set mousehide
set mousemodel=popup

" Use host clipboard
" by default
if has('win16') || has('win32') || has('win64')
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif


" === Indentation ===

" Use literal tabs
set softtabstop=4 "Soft tab size
set tabstop=4 " Tab size
set shiftwidth=4 " Visual mode indentation (match tabstop)
set noexpandtab " Don't use spaces

" Inherit indentation from previous line
set autoindent


" === Files ===

" Default encoding
set encoding=utf8

" Default line ending
set fileformat=unix

" Detection of line ending
" when opening files
set fileformats=unix,dos,mac

" Reload the file when external changes
" are detected
set autoread


" == Search ==

" Be smart about case
set smartcase

" Highlight results
set hlsearch

" Incremental search
set incsearch


" == Plugins ==


" === Syntastic ===

" Javascript
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_javascript_jslint_conf = "--on --plusplus"

" PHP
let g:syntastic_php_checkers = ['php', 'phpmd']

" Python
let g:syntastic_python_checkers = ['python', 'flake8']
