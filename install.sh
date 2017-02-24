#!/bin/bash

cmd_exists() {
  [ -x "$(command -v "$1")" ]
}

print() {
  printf "\e[0;35m$1\e[0m"
}

println() {
  print "$1\n"
}

install_zsh() {
  print 'Installing oh my zsh...'
  if ! cmd_exists 'zsh'; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  fi
  println 'done'
}

install_homebrew() {
  print 'Installing Homebrew...'
  if ! cmd_exists 'brew'; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  println 'done'
}

install_brews() {
  println 'Installing brews...'
  brew update
  brew install rbenv
  brew install python
  println 'done'
}

install_ruby() {
  println 'Installing Ruby...'
  version=2.3.3
  rbenv install -s 2.3.3
  rbenv global 2.3.3
  println 'done'
}

setup_defaults() {
  print 'Setting defaults...'
  source macos.sh
  println 'done'
}

copy_dotfiles() {
  print 'Copying dotfiles...'
  find . -type f -name ".*" -exec cp {} ~ \;
  println 'done'
  println 'Update your .gitconfig user'
}

main() {
  install_zsh
  install_homebrew
  install_brews
  install_ruby
  copy_dotfiles
  setup_defaults
}

main
