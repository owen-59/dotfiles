set fish_greeting
set -g fish_transient_prompt 1
set -g fish_key_bindings fish_vi_key_bindings

if status is-interactive
    abbr --add n nvim
    abbr --add exitup tailscale set --exit-node=server
    abbr --add exitdown tailscale set --exit-node=

    zoxide init --cmd cd fish | source
    direnv hook fish | source
    devenv hook fish | source

    SHELL=fish keychain --eval --quiet id_ed25519 | source
end
