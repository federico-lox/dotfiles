Configuration for Bash and Vim
==============================

Hello traveller,
you've reached the home of my personal *Bash* and *Vim* setup.

Feel free to grab anything you might find useful and don't be afraid to send questions over.

Farewell!

SETUP
-----

Run the following commands:

__Git__
* ln -s "`pwd`"/gitconfig ~/.gitconfig
* ln -s "`pwd`"/gitignore ~/.gitignore\_global

__Bash__
* ln -s "`pwd`"/bash\_profile ~/.bash\_profile

__Vim__
* git clone git@github.com:gmarik/vundle.git vim/bundle/vundle
* (Unix) ln -s "`pwd`"/vimrc ~/.vimrc or (Win) ln -s "`pwd`"/vimrc $HOME/\_vimrc
* ln -s "`pwd`"/vim $HOME/.vim
* vim +BundleInstall +qall
