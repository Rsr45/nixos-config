{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- This will hold the configuration.
      local config = wezterm.config_builder()

      config.font_size = 11
      config.font = wezterm.font_with_fallback({
          {
              family = "Geist Mono",
              weight = "Regular",
          }
      })

      config.color_scheme = 'wallust'
      config.automatically_reload_config = true

      config.hide_tab_bar_if_only_one_tab = true
      config.window_close_confirmation = "NeverPrompt"
      config.enable_scroll_bar = false

      return config
    '';
  };
  # home.packages = with pkgs; [
  #   wezterm
  # ];
}
