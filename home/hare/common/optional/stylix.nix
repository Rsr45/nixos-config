{
  inputs,
  pkgs,
  ...
}:
{
  # imports = [ inputs.stylix.homeManagerModules.stylix ]; # nixosModule takes care of this, for now it seems.

  stylix.targets.gtk.enable = false;
  stylix.targets.qt.enable = false;

  stylix = {
    enable = true;
    autoEnable = false;

    # iconTheme = {
    #   enable = true;
    #   package = pkgs.papirus-icon-theme;
    #   dark = "Papirus-Dark";
    #   light = "Papirus-Light";
    # };

    targets = {
      nixcord.enable = false;
      yazi.enable = false;
      fish.enable = false;
      # gtk.extraCss = ''
      #   * { border-radius: 0; box-shadow: none; }
      #
      #   window.background { border-radius: 0; }
      #
      #   .titlebar,
      #   window {
      #     border-radius: 0;
      #     box-shadow: none;
      #   }
      #
      #   decoration {
      #     box-shadow: none;
      #   }
      #
      #   decoration:backdrop {
      #     box-shadow: none;
      #   }
      #
      #   window, decoration, decoration-overlay, headerbar, .titlebar {
      #     border-bottom-left-radius: 0px;
      #     border-bottom-right-radius:0px;
      #     border-top-left-radius: 0px;
      #     border-top-right-radius: 0px;
      #   }
      # '';
      nvf = {
        enable = false;
        plugin = "mini-base16";
      };
      kitty.enable = false;
      alacritty.enable = false;
      starship.enable = false;
      nixvim = {
        enable = false;
        plugin = "mini.base16";
      };
      waybar.enable = false;
      floorp = {
        enable = false;
        colorTheme.enable = true;
        profileNames = [ "rsr" ];
      };
    };
  };
}
