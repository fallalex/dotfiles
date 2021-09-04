cp git/gitconfig ~/.gitconfig

mkdir -p ~/.config/nvim/
ln -sf `realpath vim/init.vim` ~/.config/nvim/
# run :PlugInstall

mkdir -p ~/.config/zsh/
ln -sf `realpath zsh/zshenv` ~/.zshenv
ln -sf `realpath zsh/zshrc` ~/.config/zsh/.zshrc
git clone git@github.com:seebi/dircolors-solarized.git ~/dircolors-solarized

ln -sf `realpath tmux/tmux.conf` ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# (prefix + I) to install plugins
