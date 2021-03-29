requires nvim 0.5.0+
https://github.com/neovim/neovim/wiki/Installing-Neovim

symlink:

mkdir -p ${XDGCONFIGHOME:=$HOME/.config}
ln -s ${pwd} $XDGCONFIGHOME/nvim

install vim plug: https://github.com/junegunn/vim-plug

requires the following language server options:
npm install -g typescript typescript-language-server pyright
npm install -g vue-language-server@0.0.57

requires tree-sitter-cli:
npm install -g tree-sitter-cli

npm install -g diagnostic-languageserver

execute installs:
* :PlugInstall
* :TSInstall typescript python vue lua json html css bash
