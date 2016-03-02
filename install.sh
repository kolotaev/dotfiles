#! /bin/bash

# Egor Kolotaev
#
# WHAT'S THIS? A BASH SCRIPT THAT INSTALLS AND REMOVES DOTFILES#
# It is done by symlinking dotfiles from this repo
# to corresponding ones in your home directory.

# Adds a symbolic link to files in ~/.dotfiles
# to your home directory.
function symlink_files() {
  ignoredfiles=(LICENSE readme.md install.sh get-omzsh.sh zsh-theme)

  for f in $(ls -d *); do
    if [[ ${ignoredfiles[@]} =~ $f ]]; then
      echo "Skipping $f ..."
    else
      link_file $f
    fi
  done
}

# symlink a file
# arguments: filename
function link_file(){
  echo "linking ~/.$1"
  if ! $(ln -s "$PWD/$1" "$HOME/.$1");  then
    echo "Replace file '~/.$1'?"
    read -p "[Y/n]?: " Q_REPLACE_FILE
    if [[ $Q_REPLACE_FILE != 'n' ]]; then
      replace_file $1
    fi
  fi
}

# replace file
# arguments: filename
function replace_file() {
  echo "replacing ~/.$1"
  ln -sf "$PWD/$1" "$HOME/.$1"
}
