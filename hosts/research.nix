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

  # hardware-configuration.nix
  #  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  #  boot = {
  #    loader.systemd-boot.enable = true;
  #    loader.efi.canTouchEfiVariables = true;
  #  };
}
