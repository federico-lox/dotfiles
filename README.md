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
# Unix
ln -s "`pwd`"/vimrc ~/.vimrc
# Windows
ln -s "`pwd`"/vimrc ~/_vimrc

# Unix
git clone git@github.com:gmarik/vundle.git vim/bundle/vundle
ln -s "`pwd`"/vim ~/.vim
# Windows
cp -R "`pwd`"/vim ~/.vim
cd ~/.vim
git clone git@github.com:gmarik/vundle.git vim/bundle/vundle

vim +BundleInstall +qall
```

UPDATE
------

To keep the Vim plugins up-to-date just run:
```bash
vim +BundleUpdate +qall
```
