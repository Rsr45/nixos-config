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
    # set -Ux CARAPACE_BRIDGES 'fish,zsh,bash,inshellisense' # optional
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g fish_transient_prompt 1
      set -g fish_key_bindings fish_vi_key_bindings
      set -gx fish_key_bindings fish_vi_key_bindings

      # NNN file manager
      set -gx NNN_FIFO "/tmp/nnn.fifo"
      set -gx NNN_PLUG "p:preview-tui;s:kdeconnect;c:autojump;d:dups;m:nmount;f:fixname"
      set -gx NNN_OPTS "He"
      set -gx NNN_TRASH "trash"
    '';
    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };

      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      # grease = "nvim -c 'lua require(\"oil\").open()' $argv";
      canola = "nvim -c 'lua require('canola').open()' $argv";
      # oil = ''
      #   nvim -c 'lua
      #     oil = require("oil")
      #     oil.open()
      #
      #     -- Override the close action to also quit nvim when oil closes
      #     local original_close = oil.close
      #     oil.close = function(...)
      #       original_close(...)
      #       vim.schedule(function() vim.cmd("quit") end)
      #     end'
      # '';
      oil = ''
        nvim -c 'lua
          oil = require("canola")
          oil.open()

          -- Override the close action to also quit nvim when oil closes
          local original_close = oil.close
          oil.close = function(...)
            original_close(...)
            vim.schedule(function() vim.cmd("quit") end)
          end'
      '';
      n = ''
        # Block nesting of nnn in subshells
        if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
            echo "nnn is already running"
            return
        end

        # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
        # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
        # see. To cd on quit only on ^G, remove the "-x" from both lines below,
        # without changing the paths.
        if test -n "$XDG_CONFIG_HOME"
            set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
        else
            set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
        end

        # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
        # stty start undef
        # stty stop undef
        # stty lwrap undef
        # stty lnext undef

        # The command function allows one to alias this function to `nnn` without
        # making an infinitely recursive alias
        command nnn $argv

        if test -e $NNN_TMPFILE
            source $NNN_TMPFILE
            rm -- $NNN_TMPFILE
        end
      '';
      lf = ''
        # `command` is needed in case `lfcd` is aliased to `lf`.
        # Quotes will cause `cd` to not change directory if `lf` prints nothing to stdout due to an error.
        cd "$(command lf -print-last-dir $argv)"
      '';
      y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
          builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
      '';
    };

    # bind -M insert ctrl-space complete
    # bind -M insert ctrl-n forward-char
    # bind -M insert ctrl-p backward-char
    # bind -M insert ctrl-e cancel

    preferAbbrs = true;
    shellAbbrs = config.home.shellAliases;
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
    yazi
  ];
}
