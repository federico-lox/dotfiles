" == Environment ==

" Disable Vi legacy support,
" because I like to be Very IMproved ;)
set nocompatible

" Package management with Vundle
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Using git long URL's to avoid defaulting to http
" which is being blocked in some corporate
" environments

" let Vundle manage Vundle
Bundle 'git@github.com:gmarik/vundle'

" Other bundles
Bundle 'git@github.com:mileszs/ack.vim'
Bundle 'git@github.com:kien/ctrlp.vim'
Bundle 'git@github.com:Raimondi/delimitMate'
Bundle 'git@github.com:tomasr/molokai'
Bundle 'git@github.com:altercation/vim-colors-solarized'
Bundle 'git@github.com:msanders/snipmate.vim'
Bundle 'git@github.com:scrooloose/syntastic'
Bundle 'git@github.com:majutsushi/tagbar'
Bundle 'git@github.com:juvenn/mustache.vim'
Bundle 'git@github.com:derekwyatt/vim-scala'

" Enable filetype detection, filetype
" plugins and indent files
if has("autocmd")
	filetype plugin indent on
endif


" == UI ==

" === Colors ===
" Scheme
if has("gui_running")
	set background=light
	colorscheme solarized
else
	set background=dark
	colorscheme elflord
endif

" === Typography ===

" Font
if has("gui_running")
	" Detect the platform and set the font
	" accordingly
	if has("win16") || has("win32") || has("win64")
		set guifont=Consolas:h11
	elseif has("unix")
		if has("gui_gtk") || has("gui_gtk2")
			set guifont=Ubuntu\ Mono\ 13
		else
			set guifont=Monaco:h18
		endif
	endif
endif

" Line spacing
set linespace=8


" === Highlighting ===

" Syntax highlighting
syntax on

" Highlight current line
" set cursorline

" Highliht matching brackets
set showmatch

" Highlight the current line when insert
" mode is activated
if has("autocmd") && has("gui_running")
	autocmd InsertEnter,InsertLeave * set cul!
endif

" === Elements ===

" Show line, column and percentage of scroll in status line
set ruler

" Show the name of the mode at the commandline
set showmode

" show the 80-chars guide with a different background
if exists("&colorcolumn")
	set colorcolumn=80
endif

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

" Always display the status line, even if only one window is displayed
set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2


" == Editing ==

" === Input ===

" Backspace works across lines in
" insert mode
set backspace=indent,eol,start

" Tab triggers autocompletion in
" the command line
set wildmenu
set wildmode=list:longest,full

" Enable omnicompletion for syntax
set ofu=syntaxcomplete#Complete

" Make the completion menu behave like in an IDE
set completeopt=longest,menuone

" Enable mouse in terminal UI
set mouse=a

" Hide mouse pointer while typing
set mousehide
set mousemodel=popup

" Use global cut buffer (aka clipboard)
if has('win16') || has('win32') || has('win64') || system('uname')=~'Darwin'
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm


" === Indentation ===

" Use literal tabs
set softtabstop=4 "Soft tab size
set tabstop=4 " Tab size
set shiftwidth=4 " Visual mode indentation (match tabstop)
set noexpandtab " Don't use spaces

" Inherit indentation from previous line
set autoindent


" === View ===

" Make sure the last line is displayed
" in its full length despite soft wrapping
set display+=lastline

" Keep 3 showing three lines of padding
" when scrolling down/up after/before the current line
if !&scrolloff
	set scrolloff=5
endif

" Keep showing 5 columns of padding
" when scrolling right/left after/before the current column
if !&sidescrolloff
	set sidescrolloff=5
endif

" Show trailing spaces
set listchars="trail:."
if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
	let &listchars = "trail:\u2423"
endif

" === Files ===

" Default encoding
set encoding=utf8

" Default line ending
if has('win16') || has('win32') || has('win64')
	set fileformat=dos	
else
	set fileformat=unix
endif

" Detection of line ending
" when opening files
set fileformats=unix,dos,mac

" Reload the file when external changes
" are detected
set autoread


" == Search ==

" Be smart about case,
" i.e. use case sensitiveness only if
" there's a uppercase letter in the pattern
set ignorecase
set smartcase

" Highlight results
set hlsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Incremental search
set incsearch


" === Backup, Undo, Swap ===

let s:dir = '~/.vim'

if isdirectory(expand(s:dir))
	if &directory =~# '^\.,'
		let &directory = expand(s:dir) . '/swap//,' . &directory
	endif

	if &backupdir =~# '^\.,'
		let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
	endif

	if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
		let &undodir = expand(s:dir) . '/undo//,' . &undodir
	endif
endif

if exists('+undofile')
  set undofile
endif

" == File type settings ==

if has("autocmd")
	autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
	autocmd FileType php setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
	autocmd FileType javascript setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
end

" == Plugins ==

" === Netrw ===

" open previews in a vertical split
let g:netrw_preview = 1

" === Syntastic ===

" Javascript
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_javascript_jslint_conf = "--on --plusplus"

" PHP
let g:syntastic_php_checkers = ['php', 'phpmd']

" Python
let g:syntastic_python_checkers = ['python', 'flake8']


" === Matchit ===

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
	runtime! macros/matchit.vim
endif

" === CtrlP ===

" increase maximum amount of files
let g:ctrlp_max_files = 30000

" maximum number of matches to show
let g:ctrlp_max_height = 15
