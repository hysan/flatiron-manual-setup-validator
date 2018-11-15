#!/bin/sh

# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

# https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function
# https://stackoverflow.com/questions/5615717/how-to-store-a-command-in-a-variable-in-linux
# https://stackoverflow.com/questions/17336915/return-value-in-a-bash-function
# $1 => Command to run
evaluate_test () {
  # https://stackoverflow.com/questions/11193466/echo-without-newline-in-a-shell-script
  eval $1 && printf "${GREEN}pass${NC}\n" || printf "${RED}fail${NC}\n"
}

evaluate () {
  eval $1
}

# $1 => Test Name
# $2 => Command to run
print_table_results () {
  local result=$(evaluate_test "$2")
  # https://stackoverflow.com/questions/6345429/how-do-i-print-some-text-in-bash-and-pad-it-with-spaces-to-a-certain-width
  printf "%-30s => [ %-6s ]\n" "$1" "$result"
}

# $1 => Test Name
# $2 => Command to run
print_data_row () {
  local result=$(evaluate "$2")
  # https://stackoverflow.com/questions/6345429/how-do-i-print-some-text-in-bash-and-pad-it-with-spaces-to-a-certain-width
  printf "%-12s => [ %-6s ]\n" "$1" "$result"
}

delimiter () {
  printf "${BLUE}******************************************${NC}\n"
}

delimiter
## 1. Uninstall Learn IDE

## 2. Install Xcode Command Line Tools
# https://apple.stackexchange.com/questions/219507/best-way-to-check-in-bash-if-command-line-tools-are-installed
# https://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed
# https://stackoverflow.com/questions/21272479/how-can-i-find-out-if-i-have-xcode-commandline-tools-installed
print_table_results "Xcode Command Line Tools" 'type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}"'
delimiter

## 3. N/A

## 4. Homebrew
# https://stackoverflow.com/questions/21577968/how-to-tell-if-homebrew-is-installed-on-mac-os-x
print_table_results "Homebrew" "which -s brew"
delimiter

## 5. git
# https://stackoverflow.com/questions/12254076/how-do-i-show-my-global-git-config
print_table_results "Installed git" "git version | grep -q 'git version'"
print_table_results "Github user config" "git config --list | grep -q 'github.user='"
print_table_results "Github email config" "git config --list | grep -q 'github.email='"
delimiter
print_data_row "github.user" "git config --list | grep 'github.user=' | sed 's/github.user=//g'"
print_data_row "github.email" "git config --list | grep 'github.email=' | sed 's/github.email=//g'"
delimiter

## 6. Support Libraries
print_table_results "Installed gmp" "brew list | grep -q 'gmp'"
print_table_results "Installed gnupg" "brew list | grep -q 'gnupg'"
delimiter

## 7. Ruby Version Manager (rvm)
print_table_results "Installed RVM" "which rvm | grep -q '/Users/.*/\.rvm/bin/rvm'"
print_table_results "Default RVM (2.3.3)" "rvm list | grep -Fq '=* ruby-2.3.3 [ x86_64 ]'"
print_table_results "Test RVM PATH" "rvm list | grep -Fqv 'Warning! PATH'"
delimiter

## 8. Gems
print_table_results "Gem: learn-co" "gem list | grep -q 'learn-co'"
print_table_results "Gem: bundler" "gem list | grep -q 'bundler'"
delimiter

## 9. Learn
learn whoami | grep 'Name:\|Username:\|Email:'
delimiter

## 10. Atom
print_table_results "Installed Atom" "atom -v | grep -q 'Atom'"
print_table_results "Learn Editor" "cat ~/.learn-config | grep ':editor:' | grep -q 'atom'"
delimiter

## 11. Gems (more)
print_table_results "Gem: phantomjs" "gem list | grep -q 'phantomjs'"
print_table_results "Gem: nokogiri" "gem list | grep -q 'nokogiri'"
delimiter

## 12. Databases
print_table_results "Installed sqlite" "which -s sqlite3"
print_table_results "Installed PostgreSQL" "postgres --version | grep -q 'postgres (PostgreSQL)'"
print_table_results "Installed psql" "psql --version | grep -q 'psql (PostgreSQL)'"
delimiter

## 13. Rails
print_table_results "Installed Rails" "rails --version | grep -q 'Rails'"
print_table_results "Gem: rails" "gem list | grep -q 'rails'"
delimiter

## 14. Node Version Manager (nvm)
# https://unix.stackexchange.com/questions/184508/nvm-command-not-available-in-bash-script
# https://stackoverflow.com/questions/39190575/bash-script-for-changing-nvm-node-version
. ~/.nvm/nvm.sh
print_table_results "Installed NVM" "nvm --version | grep -q '[0-9]*\.[0-9]*\.[0-9]*'"
print_table_results "Installed Node" "which node | grep -q '/Users/.*/.nvm/versions/node/v.*/bin/node'"
print_table_results "Default Node (10.x)" 'nvm version default | grep -q "v10"'
print_table_results "Default Node (6.11.2)" 'nvm version default | grep -q "v6.11.2"'
delimiter

## 15. Java
# https://stackoverflow.com/questions/36388348/check-if-java-installed-with-bash
print_table_results "Installed Java" 'java -version 2>&1 >/dev/null | grep -q "java version"'
delimiter

## 16. Google Chrome
print_table_results "Installed Google Chrome" "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version | grep -q 'Google Chrome'"
delimiter

## 17. Slack
print_table_results "Installed Slack" "/Applications/Slack.app/Contents/MacOS/Slack --version | grep -q ''"
delimiter
