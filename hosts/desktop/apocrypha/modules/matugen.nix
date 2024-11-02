{ inputs, ... }:
{
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
    palette = "default";
    templates = {
      gtk = {
        input_path = "./templates/gtk-colors.css";
        output_path = "~/.config/gtk-4.0/gtk.css";
      };
      qt5ct = {
        input_path = "./templates/qtct-colors.conf";
        output_path = "~/.config/qt5ct/colors/matugen.conf";
      };
      qt6ct = {
        input_path = "./templates/qtct-colors.conf";
        output_path = "~/.config/qt6ct/colors/matugen.conf";
      };
      hypr = {
        input_path = "./templates/hyprland-colors.conf";
        output_path = "~/.config/hypr/colors.conf";
      };
    };
  };
}
