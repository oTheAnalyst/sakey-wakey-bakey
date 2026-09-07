{
  pkgs,
  lib,
  config,
  modulesPath,
  sub,
  username,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  users.users.${sub} = {
    isNormalUser = true;
    description = sub;
    extraGroups = ["networkmanager" "i2c" "wheel"];
  };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "i2c" "wheel"];
  };

  age.secrets.secret1.file = ../secret/secret1.age;
  age.identityPaths = ["/home/pretender/.ssh/id_ed25519"];

  networking = {
    hostName = "faker";
    networkmanager.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  ### virtualisation setup
  virtualisation.libvirtd = {
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    desktopManager.plasma6.enable = true;
    tor = {
      enable = true;
      openFirewall = true;
    };
    displayManager = {
      enable = true;
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
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    kernelPackages = pkgs.linuxPackages_zen;
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
