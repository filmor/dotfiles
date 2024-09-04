if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

if type -q starship
    source (starship init fish --print-full-init | psub)
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f ~/mambaforge/bin/conda
    eval ~/mambaforge/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

fish_add_path ~/.mix/
fish_add_path ~/.local/bin/
fish_add_path ~/.cargo/bin/

# pnpm
set -gx PNPM_HOME "/home/u37166/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
