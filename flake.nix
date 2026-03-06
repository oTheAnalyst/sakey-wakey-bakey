{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    agenix.url = "github:ryantm/agenix";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {agenix, ...} @ inputs: let
    username = "pretender";
  in {
    nixosConfigurations = {
      faker = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs agenix username;};
        system = "x86_64-linux";
        modules = [
          ./modules/home
          ./hosts/faker.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
          ./modules/nixos/enviroment.nix
          ./modules/nixos/programs.nix
          ./modules/nixos/amdgpu.nix
          ./modules/nixos/postgres.nix
          ./modules/nixos/teamspeak.nix
          agenix.nixosModules.default
        ];
      };
      underblade = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username;};
        system = "x86_64-linux";
        modules = [
          ./modules/home
          ./hosts/underblade.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
          ./modules/nixos/enviroment.nix
          ./modules/nixos/programs.nix
          ./modules/nixos/amdgpu.nix
          agenix.nixosModules.default
        ];
      };
    };
  };
}
