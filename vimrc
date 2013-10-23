" == Environment ==

" Disable Vi legacy support,
" because I like to be Very IMproved ;)
set nocompatible

" Shell
"if has("win16") || has("win32") || has("win64")
"	set shellslash
"	set shell=bash.exe
"	set shellcmdflag=--login\ -c
"	set shellxquote=\"
"endif

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
Bundle 'git@github.com:vim-scripts/grep.vim'
Bundle 'git@github.com:kien/ctrlp.vim'
Bundle 'git@github.com:Raimondi/delimitMate'
Bundle 'git@github.com:msanders/snipmate.vim'
Bundle 'git@github.com:scrooloose/syntastic'
Bundle 'git@github.com:majutsushi/tagbar'
Bundle 'git@github.com:juvenn/mustache.vim'
Bundle 'git@github.com:derekwyatt/vim-scala'
Bundle 'git@github.com:elzr/vim-json'
Bundle 'git@github.com:altercation/vim-colors-solarized'
" Bundle 'git@github.com:tomasr/molokai'
Bundle 'git@github.com:rking/ag.vim'
Bundle 'git@github.com:scrooloose/nerdtree'
Bundle 'git@github.com:tpope/vim-fugitive'

" Enable filetype detection, filetype
" plugins and indent files
if has("autocmd")
	filetype plugin indent on
endif


" == UI ==

" === Colors ===
" Scheme
if has("gui_running")
	set background=dark
	colorscheme solarized
else
	set t_Co=256
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

		" Maximize the window
		au GUIEnter * simalt ~x
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

" Set current line color, disable on terminal
hi CursorLine ctermbg=Black ctermfg=NONE

" Highliht matching brackets
set showmatch

" show the 80-chars guide with a different background
" deprecated in favor of over-lenght highlight
" if exists("&colorcolumn")
" 	set colorcolumn=80
"	highlight ColorColumn ctermbg=darkblue
" endif

" Highlight text beyond line lenght limit
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=DarkGrey guibg=#591A1A
  autocmd BufEnter * match OverLength /\%80v.\+/
augroup END

" Highlight the current line when insert
" mode is activated
if has("autocmd")
	autocmd InsertEnter,InsertLeave * set cul!
endif


" === Elements ===

" Show line, column and percentage of scroll in status line
set ruler

" Show the name of the mode at the commandline
set showmode

" Show line numbers in the gutter
set number

" Remove unwanted UI elements
if has("gui_running")
	" Remove Toolbar
	set guioptions-=T

	" Remove menubar
	set guioptions-=m

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
set cmdheight=1
set shortmess=a


" == Editing ==

" === Input ===

" Backspace works across lines in
" insert mode
set backspace=indent,eol,start

" Tab triggers autocompletion in
" y
" the command line
set wildmenu
set wildmode=list:longest,full

" Enable omnicompletion for syntax
set ofu=syntaxcomplete#Complete

" Make the completion menu behave like in an IDE
set completeopt=longest,menuone

" Choose the lookup order for the tags file
set tags=./tags,tags;

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

" Remap the leader key
let mapleader=","

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
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jslint_conf = "--on --plusplus"

" PHP
let g:syntastic_php_checkers = ['php']

" Python
let g:syntastic_python_checkers = ['python', 'pylint']


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

" === grep.vim ===

" set the right find utility on Windows
" if has("win16") || has("win32") || has("win64")
	" let g:Grep_Find_Path='"%USERPROFILE%\bin\find.exe"'
	" let g:Egrep_Path='"%USERPROFILE%\bin\egrep.exe"'
	" let g:Agrep_Path='"%USERPROFILE%\bin\agrep.exe"'
" endif

" skip VCS dirs
" let g:Grep_Skip_Dirs='.git .svn'

" skip tag files
" let g:Grep_Skip_Files='tags'


" == Custom functions and commands ==
" unison shortcut
" command QuickSync :execute '!sh -c quick-sync'
" nmap <Leader>s :QuickSync<CR>

" Toggle TagBar
nnoremap <Leader>tb :TagbarToggle<CR>

" Find selection
vnoremap <Leader>fs y/<C-R>"<CR>

" Find in files
" nmap <Leader>rg :Rgrep -i<CR>
" vmap <Leader>rg <Esc>:Rgrep<CR>
" nmap <Leader>eg :Egrep<CR>
" vmap <Leader>eg <Esc>:Egrep<CR>

" Faster vimgrep short command
nnoremap <Leader>v :noautocmd vimgrep //gj **/*<Bar>:cw<left><left><left><left><left><left><left><left><left><left><left><left>
"<c-f>$Bhhi

" CtrlP short commands
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>m :CtrlPMRUFiles<CR>
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>p :CtrlPBookmarkDir<CR>

" NERDtree
nnoremap <Leader>d :NERDTree<CR>
