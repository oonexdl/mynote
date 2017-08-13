#！/bin/bash

SUBLIME_USER_DIR="$HOME/.config/sublime-text-3/Packages/User"
rm -rf $SUBLIME_USER_DIR
ln -sf $(pwd) $SUBLIME_USER_DIR
