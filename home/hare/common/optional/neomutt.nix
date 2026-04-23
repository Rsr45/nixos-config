{ ... }:
{

  programs.neomutt.enable = true;
  programs.meli.enable = true;
  programs.meli.settings = {
    shortcuts = {
      # contact-list = {
      #   create_contact = "c";
      #   edit_contact = "m";
      # };
      general = {
        # edit = "m";
        scroll_up = "Up";
        scroll_down = "Down";
        scroll_right = "Right";
        scroll_left = "Left";
      };
      listing = {
        # edit = "m";
        scroll_up = "Up";
        scroll_down = "Down";
        scroll_right = "Right";
        scroll_left = "Left";
      };
      # composing = {
      #   edit = "m";
      #   scroll_up = "e";
      #   scroll_down = "n";
      # };
      # listing = {
      #   new_mail = "t";
      #   set_seen = "s";
      # };
      # pager = {
      #   scroll_up = "e";
      #   scroll_down = "n";
      # };
    };
  };
  programs.msmtp.enable = true;
  programs.mbsync.enable = true;
  services.mbsync.enable = true;
}
