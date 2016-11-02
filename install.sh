#! /bin/bash

BAK_DIR="$HOME/.original_dotfiles"

# Add a symbolic link to files in ~/.dotfiles to your home directory.
function symlink_files() {
  ignoredfiles=(README.md install.sh, uninstall.sh)

  for f in $(ls -d *); do
    if [[ ${ignoredfiles[@]} =~ $f ]]; then
      echo "Skipping $f ..."
    else
      link_file $f
    fi
  done
}

# Symlink a file
# arguments: filename
function link_file() {
  echo "linking $1"
  if ! $(ln -s "$PWD/$1" "$HOME/.$1"); then
    f=".$1"
    replace_file $f
    echo "now attempting to link $1 once again"
    ln -s "$PWD/$1" "$HOME/.$1"
  fi
}

# replace file
# arguments: filename
function replace_file() {
  echo "Moving already existing $1 file to $BAK_DIR"
  if [ ! -d "$BAK_DIR" ]; then
    mkdir -p "$BAK_DIR"
  fi
  echo "moving $1"
  mv "$HOME/$1" "$BAK_DIR"
}

# =============== Main action goes here =================

echo "Setting up Operating System..."
set -e
(
  echo "Installing dotfiles..."
  symlink_files

  echo "Operating System setup complete."
  echo "Reloading session..."
  exec $SHELL -l

  echo "You can add .extra file to $HOME to add your shell specific custom settings"
)
