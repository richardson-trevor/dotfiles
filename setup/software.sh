#!/bin/sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    /bin/bash ../linux/software.sh || return 1
elif [[ "$OSTYPE" == "darwin"* ]]; then
    /bin/bash ../osx/software.sh || return 1
elif [[ "$OSTYPE" == "win32" ]]; then
    echo Windows isnt supported yet
else
    echo Yuh oh, we dont know what OS you on.
fi

#if -d ~/.rbenv > /dev/null 2>&1; then
#    rbenv install "$(cat ~/.rbenv/version)" --skip-existing
#fi
#
#if which gem > /dev/null 2>&1; then
#    heading 'Ruby Gems'
#    gem update
#    gem cleanup
#fi
#
#if which npm > /dev/null 2>&1; then
#    heading "NPM Update"
#    npm update -g
#fi
#
#if which vim > /dev/null 2>&1; then
#    heading "Vundle Install"
#    vim +PluginInstall! +qall
#fi
