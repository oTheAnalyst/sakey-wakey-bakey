{
  pkgs,
  agenix,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    agenix.packages.${pkgs.system}.default
    shadps4
    # utility
    microfetch
    syncthing
    teamspeak3
    #### depedency for NH
    nix-output-monitor
    nvd
    unrar
    ####
    # latex depedency
    ###
    texliveFull
    texliveTeTeX
    texstudio
    texlivePackages.enumitem
    #####
    # cli tools
    # general tools
    #####
    protonvpn-cli_2
    bitwarden-cli
    dmidecode
    gpart
    wget
    distrobox
    podman
    steam-run
    nix-prefetch-git
    hplip
    tree
    btop
    wine
    piper
    git
    libratbag
    libreoffice
    ##  nerd-fonts
    gnumake #depedency for r.nvim
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    neovim
    emacs
    # rice
    cava
    lolcat
    pfetch
    hyfetch
    ani-cli
    protonup
    #apps
    signal-desktop-bin
    rmpc
    unzip
    unrar
    zip
    zellij
    mangohud
    gallery-dl
    veracrypt
    discord
    obsidian
    obs-studio
    vlc
    cinelerra #video editing app
    mangareader
    sqlite
    sqlitebrowser
    qpwgraph
    teams-for-linux
    input-remapper
    ranger
    qbittorrent
    bitwarden-desktop
    # hyprland apps
    rainfrog
    wttrbar
    ranger
    ueberzugpp  # image previewer for ranger
    texliveFull # another latex thing
    texstudio
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
    waybar # hyprland plugin
    hyprpaper
    hyprlock
    swww # hyprland plugin
  ];
}
