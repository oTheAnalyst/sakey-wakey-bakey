{
  pkgs,
  lib,
  inputs,
  config,
  agenix,
  modulesPath,
  username,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  age.secrets.secret1.file = ../secret/secret1.age;
  age.identityPaths = ["/home/pretender/.ssh/id_ed25519"];

  programs = {
    openvpn3.enable = true;
    hyprland.enable = false;
    virt-manager.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        nix_shell = {
          symbol = " ";
          format = "$symbol ";
        };
        hostname.format = "$hostname:";
        username.format = "$user@";
      };
    };
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
    amdgpu.amdvlk.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    emacs.enable = false;
    desktopManager.plasma6.enable = true;
    teamspeak3.enable = true;
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
      wireplumber.enable = true;
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
    NH_FLAKE = "/home/pretender/sakey-wakey-bakey/";
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # custom utility
    (btop.override {rocmSupport = true;})
    agenix.packages.${pkgs.system}.default
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.shadps4
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.yazi
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.signal-desktop
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.vesktop
    inputs.zen-browser.packages.${pkgs.system}.default
    inputs.nixos-unstable.legacyPackages.${pkgs.system}.mesa
    #shadps4 depedency
    SDL2
    sndio
    jack2
    openal
    vulkan-validation-layers
    # utility
    fswebcam
    cameractrls
    cups
    syncthing
    teamspeak3
    nix-output-monitor
    nvd
    nh
    unrar
    texliveFull # another latex thing
    texliveTeTeX
    texstudio
    texlivePackages.enumitem #for latex to work
    protonvpn-cli_2
    yt-dlp
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
    rmpc
    mpd
    zip
    zellij
    catt
    gallery-dl
    veracrypt
    rstudio
    discord
    obsidian
    obs-studio
    zoom
    zoom-us
    vlc
    cinelerra #video editing app
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
    nerd-fonts.fira-code
    fira-code-symbols
    nerd-fonts.droid-sans-mono
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
