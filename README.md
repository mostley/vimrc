# VimRC

This is my vim rc for neovim, it works for me, it might not work for you but perhaps you'll find some inspiration here.

# Prerequisites

requires nvim 0.7.0+

https://github.com/neovim/neovim/wiki/Installing-Neovim

## create symlink

        mkdir -p ${XDGCONFIGHOME:=$HOME/.config}
        ln -s ${pwd} $XDGCONFIGHOME/nvim

## requires the following language server options

        pip install --upgrade python-lsp-server[all] rope pylsp-rope pylsp-mypy pyls-memestra

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

        npm install -g neovim tree-sitter-cli eslint_d diagnostic-languageserver typescript typescript-language-server pyright vls @fsouza/prettierd vscode-langservers-extracted @volar/server bash-language-server vim-language-server nginxbeautifier

        brew install efm-langserver write-good shellcheck

## trigger installations:

- :TSInstall typescript python vue lua json html css bash
- :call firenvim#install()
