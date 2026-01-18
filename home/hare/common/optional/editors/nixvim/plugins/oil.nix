{ ... }:
{
  programs.nixvim.plugins = {
    oil = {
      enable = true;
      settings = {
        use_default_keymaps = true;
        win_options = {
          signcolumn = "yes:2";
        };
        view_options = {
          show_hidden = true;
        };
        columns = [
          "permissions"
          "size"
          "mtime"
          "icon"
        ];
      };
    };

    oil-git-status.enable = true;
  };
}
