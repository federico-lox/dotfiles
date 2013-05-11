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
```bash
ln -s "`pwd`"/gitconfig ~/.gitconfig
ln -s "`pwd`"/gitignore ~/.gitignore_global
```

__Bash__
```bash
ln -s "`pwd`"/bash_profile ~/.bash_profile
```

__Vim__
```bash
git clone git@github.com:gmarik/vundle.git vim/bundle/vundle

# Unix
ln -s "`pwd`"/vimrc ~/.vimrc
# Windows
ln -s "`pwd`"/vimrc ~/_vimrc

# Unix
ln -s "`pwd`"/vim ~/.vim
# Windows
ln -s "`pwd`"/vim ~/vimfiles

vim +BundleInstall +qall
```

UPDATE
------

To keep the Vim plugins up-to-date just run:
```bash
vim +BundleUpdate +qall
```
