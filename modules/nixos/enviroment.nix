{
  pkgs,
  #agenix,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    #  agenix.packages.${pkgs.system}.default
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
    gallery-dl
    rmpc
    protonvpn-cli_2
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
    ##  nerd-fonts
    gnumake #depedency for r.nvim
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    neovim
    emacs
    # ricy gui cli
    ranger
    cava
    lolcat
    ani-cli
    microfetch
    protonup
    # utility
    syncthing
    sqlite
    sqlitebrowser
    unrar
    unzip
    unrar
    zip
    #apps
    teamspeak3
    signal-desktop-bin
    zellij
    mangohud
    veracrypt
    obsidian
    obs-studio
    vlc
    cinelerra #video editing app
    mangareader
    input-remapper
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
