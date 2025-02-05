{
  pkgs,
  lib,
  config,
  #  agenix,
  modulesPath,
  username,
  ...
}: let
  futureTeamspeakPackage = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixpkgs/fa3a54cd07014a17df3e24946c5138d5501a416c/pkgs/applications/networking/instant-messengers/teamspeak/client.nix";
    sha256 = "1jq0xgwr6lwnm57bgdynv2xm6ma6wp6rriim2lzb6xr6207pckd9";
  };
in {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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
    hostName = "faker";
    networkmanager.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  hardware = {
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

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    #(libsForQt5.callPackage futureTeamspeakPackage {})
    # agenix.packages.${pkgs.system}.default
    # utility
    #cli tools
    #inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.freetube
    zellij
    delfin
    protonvpn-cli_2
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
    cmatrix
    cava
    lolcat
    pfetch
    hyfetch
    ani-cli
    cool-retro-term
    protonup
    #apps
    libreoffice
    brave
    catt
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
    signal-desktop
    mangareader
    sqlite
    sqlitebrowser
    pgadmin4
    xclip
    qpwgraph
    alacritty
    teams-for-linux
    yazi
    qbittorrent
    bitwarden-desktop
    # hyprland apps
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
      device = "dev/disk/by-uuid/268ab858-8a6f-4aa1-a202-9f9dd1a0604a";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/5A6C-D123";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };
  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
