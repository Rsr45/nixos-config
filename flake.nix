{
  description = "Property of CCP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    schizofox.url = "github:schizofox/schizofox";
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    # zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:Rsr45/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim = {
    #   url = "github:Rsr45/nixCats-config";
    #   # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # spicetify-nix = {
    #   url = "github:Gerg-L/spicetify-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xmonad-contexts = {
      url = "github:Procrat/xmonad-contexts";
      flake = false;
    };

    thumbpick.url = "github:soliprem/thumbpick";

    omnisearch = {
      url = "git+https://git.bwaaa.monster/omnisearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Blocklists
    oisd = {
      url = "https://big.oisd.nl/domainswild";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      System = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      Pkgs = nixpkgs.legacyPackages.${System};

      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
    in
    {
      formatter = System (system: nixpkgs.legacyPackages.${system}.nixfmt);

      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs lib;
              isDarwin = false;
            };
            modules = [
              ./hosts/nixos/${host}
              sops-nix.nixosModules.sops
            ];
          };
        }) (builtins.attrNames (builtins.readDir ./hosts/nixos))
      );
    };
}
