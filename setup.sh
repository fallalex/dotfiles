cp git/gitconfig ~/.gitconfig

mkdir -p ~/.config/nvim/
ln -sf `realpath vim/init.vim` ~/.config/nvim/
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# run :PlugInstall

mkdir -p ~/.config/zsh/
ln -sf `realpath zsh/zshenv` ~/.zshenv
ln -sf `realpath zsh/zshrc` ~/.config/zsh/.zshrc
git clone git@github.com:seebi/dircolors-solarized.git ~/dircolors-solarized

mkdir -p ~/.config/ptpython/
ln -sf `realpath python/ptpython-config.py` ~/.config/ptpython/config.py
touch ~/.config/ptpython/__init__.py

ln -sf `realpath tmux/tmux.conf` ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# (prefix + I) to install plugins
