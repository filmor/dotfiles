set local_path "$HOME/.atuin/bin/env.fish"
set gentoo_path "/usr/share/atuin/shell-init/fish"

if test -e $local_path
    source $local_path
else if test -e $gentoo_path
    source $gentoo_path
end
