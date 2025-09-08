{ pkgs, inputs, hostSpec, config, ... }:
{
  home.packages = with pkgs; [
    (inputs.neovim.packages.${system}.default.override {
      packageDefinitions = {
        # the name here is the name of the package
        # and also the default command name for it.
        nixCats =
          { pkgs, name, ... }@misc:
          {
            settings = {
              suffix-path = true;
              suffix-LD = true;
              aliases = [
                "vi"
                "vim"
                "nvim"
              ];

              wrapRc = true;
              configDirName = "nixCats-nvim";
              # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
              hosts.python3.enable = true;
              hosts.node.enable = true;
            };
            categories = {
              markdown = true;
              notes = true;
              general = true;
              lint = true;
              format = true;
              neonixdev = true;
              typst = true;

              # enabling this category will enable the go category,
              # and ALSO debug.go and debug.default due to our extraCats in categoryDefinitions.
              go = true; # <- disabled but you could enable it with override or module on install

              lspDebugMode = false;
              themer = true;
              colorscheme = "moonfly";
            };
            extra = {
              nixdExtras = {
                nixpkgs = ''import ${pkgs.path} {}'';
                nixos_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options'';
                home_manager_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.${config.hostSpec.hostName}.options.home-manager.users.type.getSubOptions []'';
              };
            };
          };
        # defaultPackageName = "nixCats";
      };
    })
  ];
}
