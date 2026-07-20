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

  virtualisation.libvirtd.enable = true;

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

  environment.sessionVariables = {
    NH_FLAKE = "/home/pretender/sakey-wakey-bakey/";
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
