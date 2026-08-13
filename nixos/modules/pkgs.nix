{
    pkgs,
    nsa,
    ...
}:

{
    environment.systemPackages = with pkgs; [
        # Command Line tools
        fish
        vim
        neovim
        wget
        micro
        git
        tree
        file
        btop
        eza
        nodejs_24
        gh
        mlocate
        nixfmt-tree
        grim
        slurp
        libinput
        evtest
        ripgrep
        yazi
        tmux
        uv
        notcurses
        copyq
        zip
        unzip
        zoxide
        stow
        jc
        jq
        tree-sitter
        lua-language-server
        direnv
        bind # nslookup
        keychain
        devenv
        nsa.packages.${pkgs.system}.default


        #lsp
        lua-language-server
        pyright
        vscode-langservers-extracted
        nil
        vtsls
        gdtoolkit_4

        # system
        psmisc
        libnotify
        xdg-desktop-portal
        hyprpolkitagent
        libsForQt5.qtwayland
        pavucontrol
        bluez
        brightnessctl
        gccgo15
        python3
        hyprshot
        gvfs
        cifs-utils

        # hyprland
        hyprpaper
        hyprlock
        hypridle
        hyprpicker

        # background apps
        dunst
        rofi
        file-roller
        hyprcursor
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        networkmanagerapplet
        qview
        wlogout
        wl-clipboard
        quickshell

        # applications
        ghostty
        calibre
        vlc
        chromium
        floorp-bin
        kdePackages.dolphin
        godot
        aseprite
        texstudio
        texliveFull
    ];
}
