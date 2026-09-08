{
  pkgs,
  lib,
  config,
  modulesPath,
  user3,
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

  users.users.${user3} = {
    isNormalUser = true;
    description = user3;
    extraGroups = ["networkmanager" "i2c" "wheel"];
  };
  networking = {
    hostName = "evilbunny";
    networkmanager.enable = true;
  };

  security.intune-portal.enable = true;
  virtualisation.libvirtd.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services = {
    pulseaudio.enable = false;
    desktopManager.cosmic.enable = true;
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

  environment.sessionVariables = {
    NH_FLAKE = "/home/${user3}/sakey-wakey-bakey/";
  };

  # hardware-configuration.nix
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/mapper/luks-b12d9eb9-5923-4977-b8b4-2cbf96524278";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-b12d9eb9-5923-4977-b8b4-2cbf96524278".device = "/dev/disk/by-uuid/b12d9eb9-5923-4977-b8b4-2cbf96524278";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1AA6-358D";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
