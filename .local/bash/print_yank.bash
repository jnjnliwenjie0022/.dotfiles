#!/usr/bin/env bash

function print_yank () {
if [ -s "$HOME/yank" ]; then
    data=$(<"$HOME/yank")
    # insert at current position
    READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${data}${READLINE_LINE:READLINE_POINT}"
    # prompt move to the right hand side after the content
    READLINE_POINT=$(( READLINE_POINT + ${#data} ))
fi
}
