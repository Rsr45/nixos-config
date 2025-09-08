{ ... }:
{
  programs.nvf.settings.vim = {
    utility.motion.flash-nvim.enable = true;
    utility.motion.flash-nvim.setupOpts = {
      modes = {
        char = {
          jump_labels = true;
        };
      };
    };
    # utility.motion.leap.enable = true;
    # keymaps = [
    #   {
    #     key = "s";
    #     mode = [
    #       "n"
    #       "v"
    #     ];
    #     action = "<Plug>(leap)";
    #     desc = "Leap";
    #   }
    # ];
  };
}
