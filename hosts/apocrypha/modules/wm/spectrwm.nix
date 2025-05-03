{ ... }:
{
  xsession.windowManager.spectrwm = {
    enable = true;
    settings = {
      modkey = "Mod4";
      workspace_limit = 10;
      focus_mode = "default";
      focus_close = "next";
    };
    bindings = {
      term = "Mod+Return";
      menu = "Mod+d";
      restart = "Mod+Shift+r";
      quit = "Mod+Shift+q";
    };
    programs = {
      term = "kitty";
      menu = "bemenu-run";
      search = "dmenu -ip -p 'Window name/id:'";
    };
  };
}
