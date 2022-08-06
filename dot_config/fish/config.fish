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

