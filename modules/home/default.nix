{
  inputs,
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
    sharedModules = [
      # shared for all users
      {
        imports = [
          ./programs/kitty.nix
          ./programs/firefox.nix
          ./programs/starship.nix
        ];
        home = {
          inherit username;
          homeDirectory = "/home/${username}";
          stateVersion = lib.mkDefault config.system.stateVersion;
        };

        programs.home-manager.enable = true;
        services.ssh-agent.enable = true;
      }
    ];
  };
}
