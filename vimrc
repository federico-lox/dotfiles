" ==== Environment ====

" Use Pathogen to load plugins dynamically,
" management is done using git
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Ensure compatible shell,
" on some machines I use zsh or fish and
" it creates issues at times
set shell=/bin/bash

" disable Vi legacy support,
" because I like to be Very IMproved ;)
set nocompatible
