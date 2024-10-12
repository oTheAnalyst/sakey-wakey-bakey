{
  inputs,
  pkgs,
  username,
  lib,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs username;};
    users.${username} =
      # only for one user
      {
        imports = [
          # ./programs/kitty.nix
          ./programs/firefox.nix
          ./programs/bash.nix
         # ./programs/starship.nix
        ];
        home = {
          inherit username;
          homeDirectory = "/home/${username}";
          stateVersion = lib.mkDefault config.system.stateVersion;
          packages = with pkgs; [cowsay];
        };
        programs.home-manager.enable = true;
        services.ssh-agent.enable = true;
      };
  };
}
