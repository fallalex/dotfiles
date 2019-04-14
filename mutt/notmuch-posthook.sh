#!/bin/sh
notmuch config set database.path $HOME/.mail/$1
notmuch new
notmuch tag -new -inbox -unread +sent -- "from:$2"
notmuch tag -new +inbox +unread -- tag:new
notmuch config set database.path $HOME/.mail
