{
  pkgs,
  #agenix,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ############
    # custom utility
    ############
    (btop.override {rocmSupport = true;})
    #  agenix.packages.${pkgs.system}.default
    shadps4
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
    pastel
    tor
    scdl
    ffmpeg ## dep for scdl
    gallery-dl
    rmpc
    protonvpn-cli_2
    protonvpn-gui
    bitwarden-cli
    dmidecode
    gpart
    wget
    distrobox
    podman
    steam-run
    nix-prefetch-git
    tree
    btop
    wine
    git
    piper
    libratbag
    libreoffice
    ############
    ##  nerd-fonts
    ############
    gnumake #depedency for r.nvim
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    neovim
    emacs
    ############
    # ricy gui cli
    ############
    cava
    lolcat
    ani-cli
    microfetch
    protonup
    ############
    ## lsp clients 
    ############
    nil
    pyright
    sqls
    ############
    # utility
    ############
    syncthing
    sqlite
    sqlitebrowser
    dbeaver-bin
    unrar
    unzip
    unrar
    zip
    ############
    #apps
    ############
    vesktop
    signal-desktop-bin
    tor-browser
    zellij
    mangohud
    veracrypt
    obsidian
    obs-studio
    vlc
    davinci-resolve
    mangareader
    input-remapper
    qbittorrent
    bitwarden-desktop
    ############
    # hyprland apps
    ############
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
    light
    gammastep
    pavucontrol
    wlogout
    libnotify
    swaynotificationcenter
    wofi
    hyprpaper
    hyprlock
    swww 
  ];
}
