{pkgs, ...}: {
  # home.packages = with pkgs; [
  #   tmux
  # ];
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    # prefix = "C-a";
    shortcut = "a";
    terminal = "screen-256color";
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      unbind-key t
      bind t display-popup -E "exec tmux-sessionizer"

      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"
      bind Enter copy-mode

      unbind s
      bind s split-window -h -c "#{pane_current_path}"

      unbind v
      bind v split-window -v -c "#{pane_current_path}"

      set-option -g status-position top

      set -g status-interval 60
      WEATHER='#(curl -s wttr.in/Menemen\?format\="%%l:+%%c%%20%%t%%60%%w&period=60")'
      set -g status-right "$WEATHER ... %H:%M %d-%m-%Y"
    '';
    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-S-t"
          set -g @vim_navigator_mapping_right "C-S-d"
          set -g @vim_navigator_mapping_up "C-S-l"
          set -g @vim_navigator_mapping_down "C-S-r"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
          set -g @vim_navigator_prefix_mapping_clear_screen "" # disable the automatic mapping of <prefix> C-l to send C-l
        '';
      }
    ];
  };
}
