{
  pkgs,
  config,
  ...
}: {
  programs = {
    starship.enableFishIntegration = true;
    carapace.enableFishIntegration = false;
    zoxide.enableFishIntegration = true;
    eza.enableFishIntegration = false;
    kitty.shellIntegration.enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g fish_transient_prompt 1
      set -g fish_key_bindings fish_vi_key_bindings
    '';
    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };

      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      oil = "vi -c 'lua require(\"oil\").open()' $argv";
      grease = ''
        vi -c 'lua
          oil = require("oil")
          oil.open()

          -- Override the close action to also quit nvim when oil closes
          local original_close = oil.close
          oil.close = function(...)
            original_close(...)
            vim.schedule(function() vim.cmd("quit") end)
          end'
      '';
    };

    # bind -M insert ctrl-space complete
    # bind -M insert ctrl-n forward-char
    # bind -M insert ctrl-p backward-char
    # bind -M insert ctrl-e cancel

    preferAbbrs = true;
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };

  home.packages = with pkgs; [
    grc
  ];
}
