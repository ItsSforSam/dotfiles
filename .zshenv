# Adds rustup installed apps to PATH, if it exists properly
if [[ -f "$HOME/.cargo/env" ]]; then
	source "$HOME/.cargo/env"
fi
