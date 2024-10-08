{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
      userSettings = {
      username = "pretender";
      };
  in {
    nixosConfigurations = {
      faker = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs userSettings;};
        system = "x86_64-linux";
        modules = [
          ./hosts/faker.nix # host file, hardware, unique stuff
          ./modules/home # shared home module
          ./modules/nixos/system.nix # shared system (nixos) module
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
                inherit userSettings;
              };
              users.${userSettings.username} = {
              imports = [
              ./modules/home/default.nix #home parent
              ];
            };
           };
          }
        ];
      };
    };
  };
}
