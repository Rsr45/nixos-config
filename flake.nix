{
    description = "Property of CCP";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-21-11.url = "github:nixos/nixpkgs/nixos-21.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix";
        ags.url = "github:Aylur/ags";
    };

    outputs = { self, nixpkgs, ... } @ inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config = {
                allowUnfree = true;
            };
        };
    in
    {
        nixosConfigurations = {
            apocrypha = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs system; };
                modules = [
                    ./hosts/desktop/apocrypha/configuration.nix
                    inputs.stylix.nixosModules.stylix
                ];
            };
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs system; };
                modules = [
                    ./hosts/vm/nixos/configuration.nix
                    inputs.stylix.nixosModules.stylix
                ];
            };
        };
    };
}