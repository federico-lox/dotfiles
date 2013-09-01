Configuration for Bash and Vim
==============================

Hello traveller,
you've reached the home of my personal *Bash*, *Git*, *Emacs* and *Vim* setup.

Feel free to grab anything you might find useful and don't be afraid to send questions over.

Farewell!

SETUP
-----

Run the following commands:

__Git__
```bash
#Unix
ln -s "`pwd`"/gitconfig ~/.gitconfig
ln -s "`pwd`"/gitignore ~/.gitignore_global
#Windows
mklink /H %USERPROFILE%\.gitconfig gitconfig
mklink /H %USERPROFILE%\.gitignore_global gitignore
```

__Bash__
```bash
#Unix
ln -s "`pwd`"/bash_profile ~/.bash_profile
#Windows
mklink /H %USERPROFILE%\.bash_profile bash_profile
```

__Emacs__
```bash
#Unix
ln -s "`pwd`"/emacs ~/.emacs.d
#Windows
mklink /J %USERPROFILE%\.emacs.d emacs
```

__Vim__
```bash
# Unix
ln -s "`pwd`"/vimrc ~/.vimrc
# Windows
mklink /H %USERPROFILE%\.vimrc vimrc

# Unix
ln -s "`pwd`"/vim ~/.vim
# Windows
mklink /J %USERPROFILE%\.vim vim
#both
git clone git@github.com:gmarik/vundle.git vim/bundle/vundle
vim +BundleInstall +qall
```

UPDATE
------

To keep the Vim plugins up-to-date just run:
```bash
vim +BundleUpdate +qall
```
