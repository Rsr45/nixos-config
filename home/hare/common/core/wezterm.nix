{ lib, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- This will hold the configuration.
      local config = wezterm.config_builder()

      config.default_prog = { '${lib.getExe pkgs.nushell}', '-l' }
      config.font_size = 12
      config.font = wezterm.font_with_fallback({
          {
              family = "Iosevka",
              weight = "Regular",
          }
      })

      config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
      }

      config.window_content_alignment = {
          horizontal = 'Center',
          vertical = 'Center',
      }

      config.color_scheme = 'wallust'
      config.automatically_reload_config = true

      config.hide_tab_bar_if_only_one_tab = true
      config.window_close_confirmation = "NeverPrompt"
      config.enable_scroll_bar = false

      return config
    '';
  };
}
