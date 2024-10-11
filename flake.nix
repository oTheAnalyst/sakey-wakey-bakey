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
    username = "pretender";
  in {
    nixosConfigurations = {
      faker = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username;};
        system = "x86_64-linux";
        modules = [
          ./modules/home
          ./hosts/faker.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
        ];
      };
    };
  };
}
