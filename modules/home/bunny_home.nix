{
  inputs,
  pkgs,
  user3,
  lib,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    overwriteBackup = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs user3;};
    users.${user3} =
      # only for one user
      {
        imports = [
          ./programs/bash.nix
          ./programs/yazi.nix
          ./programs/kitty.nix
        ];
        home = {
          homeDirectory = "/home/${user3}";
          stateVersion = lib.mkDefault config.system.stateVersion;
          packages = with pkgs; [cowsay];
        };
        programs.home-manager.enable = true;
        services.ssh-agent.enable = true;
      };
  };
}
