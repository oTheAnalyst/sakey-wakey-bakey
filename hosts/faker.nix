{
  pkgs,
  lib,
  inputs,
  config,
  agenix,
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

  age.secrets.secret1.file = ../secret1.age;
  age.identityPaths = ["/home/pretender/.ssh/id_ed25519"];

  programs = {
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
  programs.virt-manager.enable = true;

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
      autoLogin.user = username;
      autoLogin.enable = true;
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "Breeze Dark";
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

  programs.firefox.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    (libsForQt5.callPackage futureTeamspeakPackage {})
    agenix.packages.${pkgs.system}.default
    shadps4
    #inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.shadps4
    # utility
    lyx
    texliveFull
    protonvpn-cli_2
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
    shadps4
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
    postgresql
    sqlitebrowser
    pgadmin4
    xclip
    qpwgraph
    freetube
    thunderbird
    alacritty
    #teamspeak_client
    teams-for-linux
    input-remapper
    ranger
    yazi
    qbittorrent
    bitwarden-desktop
    github-desktop
    rofi
    # hyprland
    waybar # hyprland plugin
    swww # hyprland plugin
    mako #hyprland plugin
  ];

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # hardware-configuration.nix
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f273fa93-d169-4f68-8553-d573918cb15a";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/AA84-F650";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
