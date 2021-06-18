requires nvim 0.5.0+
https://github.com/neovim/neovim/wiki/Installing-Neovim

symlink:

mkdir -p ${XDGCONFIGHOME:=$HOME/.config}
ln -s ${pwd} $XDGCONFIGHOME/nvim

install vim plug: https://github.com/junegunn/vim-plug

requires the following language server options:
npm install -g typescript typescript-language-server pyright
npm install -g vls
pip install python-language-server

lua language server (https://www.chrisatmachine.com/Neovim/28-neovim-lua-development/):
brew install ninja
cd .config/nvim
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
ninja -f ninja/macos.ninja
cd ../..
./3rd/luamake/luamake rebuild

required for nodjs code:
npm install -g neovim


requires tree-sitter-cli:
npm install -g tree-sitter-cli

npm install -g diagnostic-languageserver

brew install efm-langserver

execute installs:
* :PlugInstall
* :TSInstall typescript python vue lua json html css bash
