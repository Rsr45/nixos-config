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
      enableBashIntegration = false;
    };

    zoxide = {
      enableBashIntegration = true;
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    '';
  };
}
