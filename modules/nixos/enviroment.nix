{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ############
    # custom utility
    ############
    (btop.override {rocmSupport = true;})
    #  agenix.packages.${pkgs.system}.default
    ############
    #depedency for NH
    ############
    nix-output-monitor
    nvd
    ############
    # latex depedency
    ############
    texliveFull
    texliveTeTeX
    texstudio
    texlivePackages.enumitem
    #####
    # cli tools
    # general tools
    #####
    (pkgs.callPackage ./shadps4Practice.nix {})
    unrar
    unzip
    unrar
    zip
    cava
    lolcat
    ani-cli
    microfetch
    protonup-ng
    fzf
    ripgrep
    pastel
    tor
    scdl
    ffmpeg ## dep for scdl
    gallery-dl
    rmpc
    protonvpn-gui
    dmidecode
    gpart
    wget
    distrobox
    podman
    steam-run
    nix-prefetch-git
    tree
    bat
    btop
    wine
    git
    piper
    libratbag
    libreoffice
    ############
    ## neovim deps
    ############
    # custom utility
    ############
    (btop.override {rocmSupport = true;})
    #  agenix.packages.${pkgs.system}.default
    ############
    #depedency for NH
    ############
    nix-output-monitor
    nvd
    ############
    # latex depedency
    ############
    texliveFull
    texliveTeTeX
    texstudio
    texlivePackages.enumitem
    ############
    ## neovim deps
    ############
    (import ./wifi-menu.nix {inherit pkgs;})
    rustup
    cargo
    gnumake #depedency for r.nvim
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    neovim
    emacs
    ############
    ## lsp clients
    ############
    nil
    pyright
    sqls
    ############
    # utility
    ############
    cups ## printer
    gutenprint ## printer
    hplip # printer
    docker-compose
    quickemu
    pgcli
    keymapp
    syncthing
    dbeaver-bin
    nix-init
    ############
    #apps
    ############
    chromium
    zathura
    vesktop
    discord
    signal-desktop
    wasistlos
    tor-browser
    zellij
    mangohud
    veracrypt
    obsidian
    obs-studio
    vlc
    shotcut #video editor
    input-remapper
    qbittorrent
    bitwarden-desktop
    ############
    # hyprland apps
    ############
    kdePackages.gwenview
    xdg-desktop-portal-gtk
    walker
    rainfrog
    wttrbar
    yazi
    ueberzugpp # image previewer for ranger
    brightnessctl
    hyprshot
    bluetui
    playerctl
    grim
    slurp
    swappy
    gammastep
    pavucontrol
    wlogout
    libnotify
    swaynotificationcenter
    rofi
    rofi-bluetooth
    hypridle
    hyprpaper
    hyprlock
    swww
  ];
}
