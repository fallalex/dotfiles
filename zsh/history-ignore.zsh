history_ignore=(
    ' *'
    'ls'
    'ls *'
    'll'
    'll *'
    'pwd'
    'j'
    'j *'
    'z'
    'z *'
    '..'
    '~'
    'hr'
    'hl'
    'ht'
    'ss'
    'date'
    'date *'
    'dt'
    'dat'
    'o'
    'reset'
    'zoxide'
    'zoxide *'
    'clear'
    'clear *'
)
export HISTORY_IGNORE="(${(j.|.)history_ignore})"

