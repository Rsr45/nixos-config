{ config, inputs, pkgs, ... }:
{
  programs.nvf.settings.vim = {
    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      nix = {
        enable = true;
        format.type = "nixfmt";
        lsp.server = "nixd";
        lsp.options = {
          nixpkgs.expr = "import ${pkgs.path} { }";
          nixos.expr = "(builtins.getFlake \"path:${builtins.toString inputs.self.outPath}\").nixosConfigurations.configname.options";
          home-manager.expr = "(builtins.getFlake \"path:${builtins.toString inputs.self.outPath}\").nixosConfigurations.${config.hostSpec.hostName}.options.home-manager.users.type.getSubOptions []";
        };
      };

      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      go.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nu.enable = true;
      ocaml.enable = true;
      odin.enable = true;
      python.enable = true;
      rust.enable = true;
      ts.enable = true;
      typst.enable = true;
      vala.enable = true;
      zig.enable = true;
    };
  };
}
