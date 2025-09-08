{ config, ... }:
{
  # home.packages = [
  #  pkgs.vimiv-qt
  # ];
  home.file = {
    ".config/vimiv/styles/base16".text = ''
      [STYLE]
      base00 = #${config.lib.stylix.colors.base00}
      base01 = #${config.lib.stylix.colors.base01}
      base02 = #${config.lib.stylix.colors.base02}
      base03 = #${config.lib.stylix.colors.base03}
      base04 = #${config.lib.stylix.colors.base04}
      base05 = #${config.lib.stylix.colors.base05}
      base06 = #${config.lib.stylix.colors.base06}
      base07 = #${config.lib.stylix.colors.base07}
      base08 = #${config.lib.stylix.colors.base08}
      base09 = #${config.lib.stylix.colors.base09}
      base0a = #${config.lib.stylix.colors.base0A}
      base0b = #${config.lib.stylix.colors.base0B}
      base0c = #${config.lib.stylix.colors.base0C}
      base0d = #${config.lib.stylix.colors.base0D}
      base0e = #${config.lib.stylix.colors.base0E}
      base0f = #${config.lib.stylix.colors.base0F}
    '';
  };
}
