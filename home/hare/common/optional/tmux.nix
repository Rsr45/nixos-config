{ pkgs, ... }:
{
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
    ];
  };
}
