#!/bin/sh

check_dependencies() {
  if ! (which git curl > /dev/null); then
    echo "This script needs git and curl to work. So, these will be installed."
    sudo apt-get update && sudo apt-get -y install git curl
  fi
}

install_zsh() {

  echo Installing zsh...
  sudo apt-get update && sudo apt-get -y install zsh

  [ -d ~/.oh-my-zsh ] && return

  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  sed -i "s/(git)/(git colored-man-pages zsh-autosuggestions)/" ~/.zshrc
  chsh -s /bin/zsh
}

install_tmux() {
  echo Installing tmux...
  sudo apt-get update && sudo apt-get -y install tmux xclip
  curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/tmux.conf -o ~/.tmux.conf
}

install_vim() {
  echo Installing vim...
  sudo apt-get update && sudo apt-get -y install vim silversearcher-ag
  mkdir -p ~/.vim/_temp ~/.vim/_backup
  curl https://raw.githubusercontent.com/MamesPalmero/dotfiles/master/vimrc -o ~/.vimrc
  vim +PlugInstall +qa
}

install_asdf() {
  (which asdf > /dev/null) && return

  echo Installing asdf...
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3

  if [ -f ~/.zshrc ]; then
    echo '\n# asdf-vm' >> ~/.zshrc
    echo '. $HOME/.asdf/asdf.sh' >> ~/.zshrc
    echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
  fi

  if [ -f ~/.bashrc ]; then
    echo '\n# asdf-vm' >> ~/.bashrc
    echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  fi

  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
}


check_dependencies

tools=$(
whiptail --title "My UNIX environment" --notags \
  --checklist "Choose what you want to install" 20 78 4 \
  "install_zsh" "zsh      -> Shell" ON \
  "install_tmux" "tmux     -> Terminal multiplexer" ON \
  "install_vim" "vim      -> Text editor" ON \
  "install_asdf" "asdf-vm  -> Extendable version manager" ON \
  3>&1 1>&2 2>&3
)

for tool in $tools; do eval $tool; done
