history_ignore=(
    ' *'
    'ls'
    'ls *'
    'll'
    'll *'
    'l.'
    'l. *'
    'pwd'
    'j'
    'j *'
    'z'
    'z *'
    'cd'
    'cd *'
    '..'
    '~'
    'hr'
    'hl'
    'ht'
    'man *'
    'ta'
    'ta *'
    'ss'
    'date'
    'date *'
    'dt'
    'dat'
    'o'
    'reset'
    'zoxide'
    'zoxide *'
    '* --help'
    'pt'
    'open'
)
export HISTORY_IGNORE="(${(j.|.)history_ignore})"

