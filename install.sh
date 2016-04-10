#! /bin/bash
#
# WHAT'S THIS? A BASH FILE WITH FUNCTIONS?
#
# A simple bash script for setting up
# an Operating System with my dotfiles

function determine_package_manager() {
  which yum > /dev/null && {
    echo "yum"
    export OSPACKMAN="yum"
    return;
  }
  which apt-get > /dev/null && {
    echo "apt-get"
    export OSPACKMAN="apt-get"
    return;
  }
  which brew > /dev/null && {
    echo "homebrew"
    export OSPACKMAN="homebrew"
    return;
  }
}

# Installs packages.
function install_packages() {
  # general package array
  declare -a packages=('git' 'vim' 'tree' 'mc' 'wget' 'curl')

  if [[ $OSPACKMAN == "homebrew" ]]; then
    brew update
    declare -a macpackages=()
    brew install "${packages[@]}" "${macpackages[@]}"
  elif [[ "$OSPACKMAN" == "yum" ] || [ "$OSPACKMAN" == "apt-get" ]]; then
    sudo $OSPACKMAN update
    sudo $OSPACKMAN install "${packages[@]}"
  else
    echo "Unknown package manager. Exiting..."
    exit 1
  fi
}

# Removes preinstalled OS packages and files.
function remove_os_preinstalled() {
  if type vim-tiny &> /dev/null; then
      sudo $OSPACKMAN remove vim-tiny
  fi
}

# Configures vim.
function configure_vim() {
  mkdir -p ~/.dotfiles/vim/bundle
  git clone https://github.com/gmarik/vundle ~/.dotfiles/vim/bundle/vundle
}

# Adds a symbolic link to files in ~/.dotfiles
# to your home directory.
function symlink_files() {
  ignoredfiles=(LICENSE README.md install.sh)

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

# =============== Main action goes here =================

echo "Setting up Operating System..."
set -e
(
  determine_package_manager
  echo "You are running $OSPACKMAN as a package manager."

  echo "Removing unwanted packages and files..."
  remove_os_preinstalled

  echo "Now we try to install new needed packages..."
  install_packages

  echo "Installing dotfiles..."
  symlink_files

  echo "Configuring proper vim..."
  configure_vim

  # clean up env vars
  unset OSPACKMAN

  echo "Operating System setup complete."
  echo "Reloading session..."
  exec $SHELL -l
)
