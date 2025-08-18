{
  pkgs,
  agenix,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    agenix.packages.${pkgs.system}.default
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.yazi
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.vesktop
    inputs.nixos-unstable.legacyPackages.${pkgs.system}.mesa
    qutebrowser
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
    texliveFull # another latex thing
    texliveTeTeX
    texstudio
    texlivePackages.enumitem #for latex to work
    #####
    protonvpn-cli_2
    yt-dlp
    bitwarden-cli
    dmidecode
    gpart
    wget
    distrobox
    podman
    steam-run
    nix-prefetch-git
    statix
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
    cool-retro-term
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
    zoom
    zoom-us
    vlc
    cinelerra #video editing app
    mangareader
    sqlite
    sqlitebrowser
    qpwgraph
    alacritty
    teams-for-linux
    input-remapper
    ranger
    yazi
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
