{ lib, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- This will hold the configuration.
      local config = wezterm.config_builder()

      config.default_prog = { '${lib.getExe pkgs.fish}', '-l' }

      config.window_padding = {
          left = 5,
          right = 5,
          top = 10,
          bottom = 10,
      }

      config.window_content_alignment = {
          horizontal = 'Center',
          vertical = 'Center',
      }

      config.automatically_reload_config = true

      config.hide_tab_bar_if_only_one_tab = true
      config.window_close_confirmation = "NeverPrompt"
      config.enable_scroll_bar = false

      return config
    '';
  };
}
