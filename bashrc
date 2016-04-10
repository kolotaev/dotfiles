source .bashrc_os_orginal
source functions
source exports

#---------#
# EXPORTS #
#---------#

export WWWDIR = '/Applications/MAMP/htdocs'
export WORKDIR = "$HOME/work"

#---------#
# ALIASES #
#---------#

# common unix commands
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias recd="cd .. && cd -"
alias cw = cd $work
alias cww = cd $www
alias g = git
alias ll = ls -la

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

alias reload = "exec $SHELL -l"

# bundler
alias bex = "bundler exec"

# OSX specific #

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
