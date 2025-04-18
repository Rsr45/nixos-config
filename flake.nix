{
  description = "Property of CCP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    schizofox.url = "github:schizofox/schizofox";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvf.url = "github:notashelf/nvf";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages."${system}".linux.nixfmt-rfc-style;
      nixosConfigurations = {
        apocrypha = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/desktop/apocrypha/configuration.nix
          ];
        };
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/vm/nixos/configuration.nix
          ];
        };
        heaven = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/desktop/heaven/configuration.nix
          ];
        };
      };
    };
}
