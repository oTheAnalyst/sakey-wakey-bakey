{pkgs, ...}: let
  wifi-menu = pkgs.writeShellScriptBin "wifi-menu" ''
        notify-send "Getting list of available Wi-Fi networks..."
    # Get a list of available wifi connections and morph it into a nice-looking list
        wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

        connected=$(nmcli -fields WIFI g)
        if [[ "$connected" =~ "enabled" ]]; then
            toggle="󰖪  Disable Wi-Fi"
        elif [[ "$connected" =~ "disabled" ]]; then
            toggle="󰖩  Enable Wi-Fi"
        fi

    # Use rofi to select wifi network
        chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " )
    # Get name of connection

        read -r chosen_id <<<  "''${chosen_network:3}"

        if [ "$chosen_network" = "" ]; then
            exit
        elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
            nmcli radio wifi on
        elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
            nmcli radio wifi off
        else
            # Message to show when connection is activated successfully
              success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
            # Get saved connections
            saved_connections=$(nmcli -g NAME connection)
            if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
                nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
            else
                if [[ "$chosen_network" =~ "" ]]; then
                    wifi_password=$(rofi -dmenu -p "Password: " )
                fi
                nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
            fi
        fi
  '';
in {
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
    ############
    ## neovim deps
    ############
    wifi-menu
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
    docker-compose
    quickemu
    pgcli
    keymapp
    ventoy-full
    syncthing
    dbeaver-bin
    nix-init
    ############
    #apps
    ############
    shadps4
    chromium
    zathura
    vesktop
    discord
    signal-desktop-bin
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
    light
    gammastep
    pavucontrol
    wlogout
    libnotify
    swaynotificationcenter
    rofi
    rofi-bluetooth
    hyprpaper
    hyprlock
    swww
  ];
}
