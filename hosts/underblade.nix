{
  pkgs,
  lib,
  config,
  inputs,
  #  agenix,
  modulesPath,
  username,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  #age.secrets.secret1.file = ../secret1.age;

  programs = {
    hyprland.enable = true;
    virt-manager.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "underblade";
    networkmanager.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    pulseaudio.enable = false;
  };

  services = {
    emacs.enable = true;
    desktopManager.plasma6.enable = true;
    teamspeak3.enable = true;
    postgresql = {
      enable = true;
      ensureDatabases = ["mydatabase"];
      enableTCPIP = true;
      # port = 5432;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBuser origin-address auth-method
        local all      all     trust
        # ... other auth rules ...

        # ipv4
        host  all      all     127.0.0.1/32   trust
        # ipv6
        host  all      all     ::1/128        trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
        CREATE DATABASE nixcloud;
        CREATE USER 'nixcloud'@'localhost' WITH ENCRYPYED PASSWORD 'testerac';
        GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
      '';
    };
    displayManager = {
      autoLogin = {
        user = username;
        enable = true;
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "breeze";
        settings.Autologin.Session = "hyprland";
      };
    };
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      videoDrivers = ["amdgpu"];
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.openrgb.enable = true;

    ratbagd.enable = true;
  };

  security.rtkit.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];
  };

  environment.sessionVariables = {
    FLAKE = "/home/pretender/sakey-wakey-bakey/";
  };
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    # agenix.packages.${pkgs.system}.default
    # utility
    teamspeak3
    #cli tools
    nix-prefetch-github
    nix-output-monitor
    nvd
    nh
    #inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.freetube
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.signal-desktop
    zellij
    delfin
    protonvpn-cli_2
    protonvpn-gui
    bitwarden-cli
    dmidecode
    wget
    tree
    btop
    wine
    piper
    git
    mangohud
    libratbag
    nerdfonts
    neovim
    # rice
    tor
    tor-browser
    cmatrix
    cava
    lolcat
    pfetch
    hyfetch
    ani-cli
    protonup
    #apps
    brave
    libreoffice
    gallery-dl
    veracrypt
    rstudio
    discord
    obsidian
    obs-studio
    vesktop
    zoom-us
    vlc
    cinelerra #video editing app
    mangareader
    sqlite
    sqlitebrowser
    gcc14
    pgadmin4
    qpwgraph
    teams-for-linux
    qbittorrent
    bitwarden-desktop
    # hyprland apps
    rainfrog
    wttrbar
    ranger
    texliveFull # another latex thing
    texstudio
    brightnessctl
    hyprshot
    bluetui
    playerctl
    yt-dlp
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

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # hardware-configuration.nix
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "dev/disk/by-uuid/c2b7867b-e20f-421d-9039-c02947dd2f88";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/115A-DACB";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };
  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
