{ ... }:
{
  programs.nixvim.plugins = {

    flit = {
      enable = true;
      settings = {
        keys = {
          F = "F";
          T = "T";
          f = "f";
          t = "t";
        };
        labeled_modes = "nv";
        multiline = true;
      };
    };
  };
}
