{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    agenix.url = "github:ryantm/agenix";
    nixpkgs-unstable.url = "github:nixos/nixpjgs/unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shadps4 = {
      url = "github:shadps4-emu/shadPS4";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    agenix,
    shadps4,
    ...
  } @ inputs: let
    username = "pretender";
  in {
    nixosConfigurations = {
      faker = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs agenix username shadps4;};
        system = "x86_64-linux";
        modules = [
          ./modules/home
          ./hosts/faker.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
          agenix.nixosModules.default
          shadps4.nixosModules.default
        ];
      };
      real = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username;};
        system = "x86_64-linux";
        modules = [
          ./modules/home
          ./hosts/real.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
          # agenix.nixosModules.default
        ];
      };
    };
  };
}
