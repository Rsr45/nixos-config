{ ... }:
{
  programs.nixvim.plugins.flash = {
    enable = true;
    settings.modes.char.jump_labels = true;
  };
}
