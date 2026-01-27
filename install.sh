#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
	bin_dir="${HOME}/.local/bin"
	chezmoi="${bin_dir}/chezmoi"
	echo "Installing chezmoi to '${chezmoi}'" >&2
	if command -v curl >/dev/null; then
		download_cmd="curl -fsSL https://get.chezmoi.io"
	elif command -v wget >/dev/null; then
		download_cmd="wget -qO- https://get.chezmoi.io"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
	if ! chezmoi_install_script="$(${download_cmd})"; then
		echo "Failed to download chezmoi install script, falling back to local chezmoi-install.sh" >&2
		if [ -f "./chezmoi-install.sh" ]; then
			chezmoi_install_script="$(cat "$(dirname "$0")/chezmoi-install.sh")"
		else
			echo "Local chezmoi-install.sh not found." >&2
			exit 1
		fi
	fi
	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
	unset chezmoi_install_script bin_dir download_cmd
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

if [ "$CODER" = "true" ]; then
	set -- init --one-shot --source="${script_dir}"
else
	set -- init --apply --source="${script_dir}"
fi

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
