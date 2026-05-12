#!/usr/bin/env bash
# 檢查檔案是否存在且大小大於 0
#if [ -s "$HOME/yank" ]; then
#    data=$(cat "$HOME/yank")
#
#    # 將內容插入到目前的游標位置 ($READLINE_POINT)
#    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${data}${READLINE_LINE:$READLINE_POINT}"
#
#    # 將游標移動到插入內容之後
#    READLINE_POINT=$(( READLINE_POINT + ${#data} ))
#fi
function print_yank () {
if [ -s "$HOME/yank" ]; then
    data=$(<"$HOME/yank")

    READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${data}${READLINE_LINE:READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#data} ))
fi
}
