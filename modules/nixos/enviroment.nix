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
    #### depedency for NH
    nix-output-monitor
    nvd
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
    git
    piper
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
    # utility
    sqlite
    sqlitebrowser
    microfetch
    unrar
    unzip
    unrar
    zip
    #apps
    syncthing
    teamspeak3
    signal-desktop-bin
    rmpc
    zellij
    mangohud
    gallery-dl
    veracrypt
    obsidian
    obs-studio
    vlc
    cinelerra #video editing app
    mangareader
    teams-for-linux
    input-remapper
    ranger
    qbittorrent
    bitwarden-desktop
    # hyprland apps
    rainfrog
    wttrbar
    ranger
    ueberzugpp # image previewer for ranger
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
