if status is-interactive
  # Commands to run in interactive sessions can go here
end

function fish_greeting
end

if type -q starship
  source (starship init fish --print-full-init | psub)
end

fish_add_path ~/.mix/escripts/
fish_add_path ~/.local/bin/
fish_add_path ~/.cargo/bin/

# pnpm
set -gx PNPM_HOME $(realpath ~/.local/share/pnpm)
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

if type -q mise
  mise activate fish | source
end
