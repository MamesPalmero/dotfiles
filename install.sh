#!/bin/bash

install_asdf() {
  rm -rf ~/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.2

  if ! grep -q "asdf-vm" ~/.bashrc; then
    {
      echo -e "\n# asdf-vm"
      echo ". $HOME/.asdf/asdf.sh"
      echo ". $HOME/.asdf/completions/asdf.bash"
    } >> ~/.bashrc
  fi

  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
}

check_and_install_requirements() {
  echo "Checking requirements..."
  if which whiptail git curl asdf > /dev/null; then
    echo "OK"
    return
  fi

  echo "This script needs git, curl and asdf to work. So, these will be installed."
  echo "Installing whiptail, git, curl and asdf..."
  sudo apt-get update && sudo apt-get -y install whiptail git curl && install_asdf
}

install_zsh() {

  echo Installing zsh...
  sudo apt-get update && sudo apt-get -y install zsh

  [ -d ~/.oh-my-zsh ] && return

  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  sed -i "s/(git)/(git colored-man-pages zsh-autosuggestions)/" ~/.zshrc
  echo '\n# Disable auto_cd to avoid collisions between executables and folders called same' >> ~/.zshrc
  echo "unsetopt auto_cd" >> ~/.zshrc
  chsh -s /bin/zsh
}

install_tmux() {
  echo Installing tmux...
  sudo apt-get update && sudo apt-get -y install tmux xclip
  curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/tmux.conf -o ~/.tmux.conf
}

install_vim() {
  echo Installing vim...
  sudo apt-get update && sudo apt-get -y install vim-gnome silversearcher-ag
  mkdir -p ~/.vim/_temp ~/.vim/_backup
  curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/vimrc -o ~/.vimrc
  vim +PlugInstall +qa
}

install_nvim() {
  echo Installing nvim...
  sudo curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -o /usr/local/bin/nvim
  sudo chmod +x /usr/local/bin/nvim
  curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/nvim/init.vim --create-dirs -o ~/.config/nvim/init.vim
  mkdir ~/.config/nvim/_temp ~/.config/nvim/_backup
  nvim +PlugInstall +qa
}


check_and_install_requirements

tools=$(
whiptail --title "My UNIX environment" --notags \
  --checklist "Choose what you want to install" 20 78 5 \
  "install_zsh" "zsh      -> Shell" ON \
  "install_tmux" "tmux     -> Terminal multiplexer" ON \
  "install_vim" "vim      -> Text editor" OFF \
  "install_nvim" "nvim     -> Text editor" ON \
  3>&1 1>&2 2>&3
)

for tool in $tools; do eval "$tool"; done
