{lib, ...}: {
  # imports = lib.flatten [
  #   (map lib.custom.relativeToRoot [
  #     # ========== X ==========
  #     # Never to be removed at all must have ...
  #     "home/common/core"
  #     "home/common/optional/xdg-portal.nix"
  #
  #     # ========== X ==========
  #     # WM/DE homemanager eq
  #     "home/common/optional/sway.nix"
  #
  #     # ========== X ==========
  #     # Sys ui themeing/qt/gtk etc
  #     "home/common/core/qt.nix"
  #     "home/common/core/kvantum.nix"
  #     "home/common/optional/gtk.nix"
  #   ])
  # ];
}
