# Prerequisites

requires nvim 0.5.0+

https://github.com/neovim/neovim/wiki/Installing-Neovim

## create symlink

        mkdir -p ${XDGCONFIGHOME:=$HOME/.config}
        ln -s ${pwd} $XDGCONFIGHOME/nvim

## requires the following language server options

        npm install -g typescript typescript-language-server pyright
        npm install -g vls
        pip install python-language-server
        npm install -g @fsouza/prettierd
        npm i -g vscode-langservers-extracted

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

        npm install -g neovim

        npm install -g tree-sitter-cli

        npm install -g diagnostic-languageserver

        brew install efm-langserver

        brew install write-good

## execute installs:

- :TSInstall typescript python vue lua json html css bash
