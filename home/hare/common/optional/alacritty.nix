{ pkgs, ... }:
{
  home.packages = [ pkgs.alacritty ];
  # programs.alacritty = {
  #   enable = false;
  #   # settings = {
  #   #   general = {
  #   #     import = ["colors.toml"];
  #   #   };
  #     # font = {
  #     #   size = 14;
  #     #   # normal = [
  #     #   #   family = "BlexMonoNerdFont";
  #     #   #   style = "Regular";
  #     #   # ];
  #     # };
  #   };
  # };
}
