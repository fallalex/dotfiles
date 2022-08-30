# https://wiki.archlinux.org/title/XDG_Base_Directory
# https://bbs.archlinux.org/viewtopic.php?id=227166
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
# Application data that survives restart i.e. logs and history
export XDG_STATE_HOME="$HOME/.local/state"

export VIM_PLUG_VIM="$XDG_DATA_HOME/nvim/site/autoload"
export FZF_ROOT="$XDG_DATA_HOME/fzf"
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PTPYTHON_CONFIG_HOME="$XDG_CONFIG_HOME/ptpython/"
export PTPYTHON_HISTORY="$XDG_STATE_HOME/python/ptpython-history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/python-startup.py"

export LESSHISTFILE=/dev/null

export GITLAB_HOST=gitlab.eng.vmware.com
export GITLAB_GROUP=28764
export GITLAB_GROUP_NAME=cmbu-tvg

export TVS_PROJECT_DATA="$HOME/tvs-project-data"
export COLLECTIONS_DIR="$TVS_PROJECT_DATA/collections"
export TVS_ACTIVE_PROJECTS_REPLICA="$HOME/repos/gitlab.eng.vwmware.com/active-projects-replica"

export TVS_PROJECTS="$TVS_PROJECT_DATA/tvs-projects.json"
export TVS_ACTIVE_PROJECTS="$TVS_PROJECT_DATA/tvs-active-projects.json"
export TVS_DPS="$TVS_PROJECT_DATA/tvs-dps.json"
export TVS_MPS="$TVS_PROJECT_DATA/tvs-mps.json"
export TVS_PROJECT_SEARCH="$TVS_PROJECT_DATA/tvs-search.json"

