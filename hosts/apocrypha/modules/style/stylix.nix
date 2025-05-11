{
  inputs,
  pkgs,
  ...
}:
{
  # imports = [ inputs.stylix.homeManagerModules.stylix ]; # nixosModule takes care of this, for now it seems.

  stylix = {
    enable = true;

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    targets = {
      nixcord.enable = false;
      yazi.enable = false;
      gtk.extraCss = ''
        // Remove rounded corners
        window.background { border-radius: 0; }
      '';
      nvf = {
        enable = true;
        # plugin = "mini-base16";
      };
      waybar.addCss = true;
      floorp = {
        enable = true;
        colorTheme.enable = true;
        profileNames = [ "rsr" ];
      };
      firefox = {
        enable = true;
        colorTheme.enable = true;
        profileNames = [ "schizofox" ];
      };
    };
  };
}
