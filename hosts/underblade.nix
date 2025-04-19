{
  pkgs,
  lib,
  config,
  inputs,
  agenix,
  modulesPath,
  username,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  age.secrets = {
    secret1.file = ../secret/secret1.age;
    s2.file = ../secret/s2.age;
    s3.file = ../secret/s3.age;
  };

  age.identityPaths = [
    "/home/pretender/.ssh/ed123"
    "/home/pretender/.ssh/id_ed25519"
    "/home/pretender/.ssh/glitterknife"
  ];

  programs = {
    openvpn3.enable = true;
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
    inputs.agenix.packages."${system}".default
    #    agenix.packages.${pkgs.system}.default
    # utility
    teamspeak3
    cups
    #cli tools
    unzip
    gnumeric
    nix-prefetch-github
    nix-output-monitor
    nvd
    nh
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.shadps4
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.signal-desktop
    inputs.zen-browser.packages.${pkgs.system}.default
    zellij
    openresolv
    protonvpn-gui
    delfin
    wireguard-tools
    dmidecode
    wget
    tree
    btop
    wine
    piper
    git
    ## graphics
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
    #apps coms & privacy
    citrix_workspace
    tor
    tor-browser
    ani-cli
    protonup
    libreoffice
    gallery-dl
    veracrypt
    rstudio
    discord
    ### test framework
    zathura
    snakemake
    nextflow
    obsidian
    obs-studio
    vesktop
    vlc
    cinelerra #video editing app
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
