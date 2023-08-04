# VimRC

This is my vim rc for neovim, it works for me, it might not work for you but perhaps you'll find some inspiration here.

https://dotfyle.com/mostley/vimrc

# Prerequisites

requires nvim 0.9.0+

https://github.com/neovim/neovim/wiki/Installing-Neovim

## create symlink

        mkdir -p ${XDGCONFIGHOME:=$HOME/.config}
        ln -s ${pwd} $XDGCONFIGHOME/nvim

## requires the following language server options

        python3 -m pip install --user --upgrade pynvim
        pip install --upgrade python-lsp-server[all] rope pylsp-rope pylsp-mypy pyls-memestra gitlint proselint

        npm install -g neovim tree-sitter-cli eslint_d diagnostic-languageserver typescript typescript-language-server pyright vls @fsouza/prettierd vscode-langservers-extracted @volar/vue-language-server bash-language-server vim-language-server nginxbeautifier alex proselint markdownlint

        brew install efm-langserver write-good shellcheck

## other needed things

        brew install ranger rg fd

## trigger installations:

- :TSInstall typescript python vue lua json html css bash
