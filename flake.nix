{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs?ref=nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
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
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.neovim ];
    };
  nixosConfigurations = {
     nixos = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs system; };
       modules = [
         ./hosts/fangyuan/configuration.nix
         inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
