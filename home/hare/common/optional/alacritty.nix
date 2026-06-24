{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal = {
        shell = {
          program = "fish";
          args = [
            "-l"
          ];
        };
      };
      keyboard = {
        bindings = [
          {
            key = "PageUp";
            action = "ScrollPageUp";
          }
          {
            key = "PageDown";
            action = "ScrollPageDown";
          }
        ];
      };
    };
  };
}
