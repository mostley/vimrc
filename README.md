symlink:

mkdir -p ${XDGCONFIGHOME:=$HOME/.config}
ln -s ${pwd} $XDGCONFIGHOME/nvim
