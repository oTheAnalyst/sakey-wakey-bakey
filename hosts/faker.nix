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
  firefox.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
    openvpn3.enable = true;
    hyprland.enable = true;
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

  ### virtualisation setup
  virtualisation.libvirtd = {
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    emacs.enable = false;
    desktopManager.plasma6.enable = true;
    teamspeak3.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "/home/pretender/musicDirectory";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
      network.listenAddress = "any";
    };
    displayManager = {
      autoLogin.user = username;
      autoLogin.enable = true;
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
    extraGroups = ["networkmanager" "libvirtd" "wheel"];
  };

  environment.sessionVariables = {
    NH_FLAKE = "/home/pretender/sakey-wakey-bakey/";
  };

  # List packages installed in system profile
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
