#!/bin/sh
notmuch config set database.path $HOME/.mail/$1
notmuch search --output=files --format=text0 tag:deleted | xargs -0 rm -v
notmuch new
notmuch config set database.path $HOME/.mail
