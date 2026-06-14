{
  pkgs,
  lib,
  username,
  ...
}: {
  networking = {
    hostName = "faker"; ## edit this
  };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
  };

  environment.sessionVariables = {
    NH_FLAKE = "/home/pretender/sakey-wakey-bakey/";
  };

  # List packages installed in system profile
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code-symbols
    nerd-fonts.droid-sans-mono
  ];

  ##fileSystems = {
  ##  "/" = {
  ##    device = "dev/disk/by-uuid/c2b7867b-e20f-421d-9039-c02947dd2f88";
  ##    fsType = "ext4";
  ##  };
  ##  "/boot" = {
  ##    device = "/dev/disk/by-uuid/115A-DACB";
  ##    fsType = "vfat";
  ##    options = ["fmask=0077" "dmask=0077"];
  ##  };
  ##};

  # hardware-configuration.nix
  #  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  #  boot = {
  #    loader.systemd-boot.enable = true;
  #    loader.efi.canTouchEfiVariables = true;
  #  };
}
