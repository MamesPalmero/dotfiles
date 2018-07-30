#!/bin/sh

echo Installing pre-requisites
sudo apt-get update
sudo apt-get -y install git zsh tmux vim-gnome silversearcher-ag xclip

echo Installing tools to customize shell and editor
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo Installing custom settings
curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/vimrc -o ~/.vimrc
curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/tmux.conf -o ~/.tmux.conf

echo Installing vim plugins
vim -c ":PlugInstall" -c ":qa"

echo Changing default shell to zsh
chsh -s /bin/zsh
zsh
