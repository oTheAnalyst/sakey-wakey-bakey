{
  pkgs,
  lib,
  config,
  modulesPath,
  username,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  #  age.secrets = {
  #    secret1.file = ../secret/secret1.age;
  #    s2.file = ../secret/s2.age;
  #    s3.file = ../secret/s3.age;
  #  };
  #
  #  age.identityPaths = [
  #    "/home/pretender/.ssh/ed123"
  #    "/home/pretender/.ssh/id_ed25519"
  #    "/home/pretender/.ssh/glitterknife"
  #  ];
  #

  networking = {
    hostName = "underblade";
    networkmanager.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "i2c" "podman" "wheel"];
  };
  virtualisation.libvirtd.enable = true;
  # Arion works with Docker, but for NixOS-based containers, you need Podman
  # since NixOS 21.05.
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  ##  virtualisation.podman.defaultNetwork.dnsname.enable = true;

  # Use your username instead of `myuser`

  services = {
    pulseaudio.enable = false;
    desktopManager.plasma6.enable = true;
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
    pipewire = {
      wireplumber.extraConfig.no-ucm = {
        "monitor.alsa.properties" = {
          "alsa.use-ucm" = false;
        };
      };
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

  environment = {
    sessionVariables = {
      NH_FLAKE = "/home/pretender/sakey-wakey-bakey/";
    };

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # hardware-configuration.nix
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod"];
    kernelModules = ["kvm-amd"];
    kernelPackages = pkgs.linuxPackages_zen;
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
