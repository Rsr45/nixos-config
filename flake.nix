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
    hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    schizofox.url = "github:schizofox/schizofox";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs = {
      # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
    # zen-browser.url = "github:youwen5/zen-browser-flake";
    # zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:Rsr45/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };
    neovim = {
      url = "github:Rsr45/nixCats-config";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    xmonad-contexts = {
      url = "github:Procrat/xmonad-contexts";
      flake = false;
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-v4 = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thumbpick.url = "github:soliprem/thumbpick";

    omnisearch = {
      url = "git+https://git.bwaaa.monster/omnisearch";
      inputs.nixpkgs.follows = "nixpkgs";
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
