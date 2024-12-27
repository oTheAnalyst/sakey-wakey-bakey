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
    # teamspeak3.enable = true;
    displayManager = {
      autoLogin = {
        user = username;
        enable = true;
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "breeze";
      };
      setting = {
        Autologin.Session = "hyprland";
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
    (libsForQt5.callPackage futureTeamspeakPackage {})
    # agenix.packages.${pkgs.system}.default
    # utility
    bitwarden-cli
    dmidecode
    gpart
    gparted
    rocmPackages.rocm-smi
    wget
    system-config-printer
    nix-prefetch-git
    statix
    hplip
    tree
    btop
    wine
    piper
    git
    mangohud
    libratbag
    nerdfonts
    gnumake #depedency for r.nvim
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    neovim
    # rice
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
    zoom
    zoom-us
    vlc
    cinelerra #video editing app
    signal-desktop
    mangareader
    sqlite
    sqlitebrowser
    postgresql
    pgadmin4
    xclip
    qpwgraph
    freetube
    thunderbird
    alacritty
    #teamspeak_client
    delfin
    teams-for-linux
    input-remapper
    ranger
    yazi
    qbittorrent
    bitwarden-desktop
    github-desktop
    mov-cli
    pipx
    # hyprland
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
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "dev/disk/by-uuid/c6da761c-9f9c-4489-8b9a-b428b31e0baf";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/3400-3919";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
