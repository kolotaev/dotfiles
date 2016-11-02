#! /bin/bash

BAK_DIR="$HOME/.original_dotfiles"

# delete symlinks
function delete_symlinks() {
  ignoredfiles=(README.md install.sh, uninstall.sh)

  for f in $(ls -d *); do
    if [[ ${ignoredfiles[@]} =~ $f ]]; then
      echo "Skipping $f ..."
    else
      if [[ -f "$HOME/.$f" && -L "$HOME/.$f" ]]; then
        echo "Deleting symlink .$f from $HOME"
        rm "$HOME/.$f"
      fi
    fi
  done
}

# restore backed-up files
function restore_from_backup() {
  for f in $(ls -A $BAK_DIR); do
    echo "Putting backed-up file $f from back to $HOME"
    mv "$BAK_DIR/$f" "$HOME/$f"
  done
}

echo "Rolling-back Operating System..."

set -e
(
  echo "Uninstalling dotfiles..."
  delete_symlinks

  echo "Restoring from backup"
  restore_from_backup

  echo "Removing $BAK_DIR - it's not longer needed"
  rm -r $BAK_DIR

  echo "Operating System rollback complete."
  echo "Reloading session..."
  exec $SHELL -l
)
