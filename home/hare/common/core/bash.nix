{ ... }:
{
  programs = {
    carapace = {
      enable = true;
      enableBashIntegration = true;
    };

    starship = {
      enableBashIntegration = true;
    };

    eza = {
      enableBashIntegration = true;
    };

    zoxide = {
      enableBashIntegration = true;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      cd = "z";
      cdi = "zi";
      ci = "zi";
      v = "vimiv";
      view = "vimiv";
      e = "nvim";
      edit = "nvim";
      y = "yazi";
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
    };

    bashrcExtra = ''
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    '';
  };
}
