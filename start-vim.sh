#!/bin/bash

echo 'Installing pathogen.vim'
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo 'Cloning nerdcommenter'
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter

# For persistent undo
mkdir ~/.vim/undodir

curl 'https://raw.githubusercontent.com/carlosflrs/dotfiles/master/vimrc' > ~/.vimrc
