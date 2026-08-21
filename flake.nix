{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    fuzzy-search-yazi = {
      url = "github:onelocked/fuzzy-search.yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    bakey-wakey.url = "github:oTheAnalyst/bakey-wakey";
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

  outputs = {
    agenix,
    nix-flatpak,
    ...
  } @ inputs: let
    username = "pretender";
    sub = "atlas";
  in {
    nixosConfigurations = {
      faker = inputs.nixos-unstable.lib.nixosSystem {
        specialArgs = {inherit inputs agenix username sub;};
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          agenix.nixosModules.default
          ./modules/home
          ./hosts/faker.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
          ./modules/nixos/enviroment.nix
          ./modules/nixos/services.nix
          ./modules/nixos/amdgpu.nix
          ./modules/nixos/postgres.nix
        ];
      };
      underblade = inputs.nixos-unstable.lib.nixosSystem {
        specialArgs = {inherit inputs username sub;};
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          agenix.nixosModules.default
          ./modules/home
          ./hosts/underblade.nix # host file, hardware, unique stuff
          ./modules/nixos/system.nix # shared system (nixos) module
          ./modules/nixos/enviroment.nix
          ./modules/nixos/services.nix
          ./modules/nixos/amdgpu.nix
        ];
      };
    };
  };
}
