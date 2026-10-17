{config, ...}: {
  programs.starship.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    history = {
      append = true;
      share = true;
      extended = true;
      ignoreSpace = true;
      ignoreAllDups = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    dotDir = "${config.xdg.configHome}/zsh";

    zsh-abbr = {
      enable = false; # why the hell are my quotes gone ??
      abbreviations = config.home.shellAliases;
    };

    antidote = {
      enable = true;
      plugins = [
        # "getantidote/use-omz"
        "zsh-users/zsh-syntax-highlighting"
        # "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        # "zsh-users/zsh-history-substring-search"
        "MichaelAquilina/zsh-auto-notify"
      ];
    };

    initContent = ''
      zstyle ':completion:*' insert-tab false
      # allows modern completion ui ??
      zstyle ':completion:*' menu select
      # Carapace
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      autoload -U select-word-style
      select-word-style bash

      # zstyle ':completion:*' list-lines 15

      bindkey -e

      bindkey '^ ' menu-complete
      bindkey '^n' menu-complete
      bindkey '^p' reverse-menu-complete
      bindkey '^I' menu-complete
      bindkey '^[[Z' reverse-menu-complete

      oil () {
          nvim -c 'lua
          oil = require("oil")
          oil.open()

          -- Override the close action
          local original_close = oil.close
          oil.close = function(...)
            original_close(...)
            vim.schedule(function() vim.cmd("quit") end)
          end'
      }

      function y() {
          local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          command yazi "$@" --cwd-file="$tmp"
          IFS= read -r -d ''' cwd < "$tmp"
          [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
          command rm -f -- "$tmp"
      }

      n ()
      {
          # Block nesting of nnn in subshells
          [ "''${NNNLVL:-0}" -eq 0 ] || {
              echo "nnn is already running"
              return
          }

          # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
          # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
          # see. To cd on quit only on ^G, remove the "export" and make sure not to
          # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
          #      NNN_TMPFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
          export NNN_TMPFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

          # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
          # stty start undef
          # stty stop undef
          # stty lwrap undef
          # stty lnext undef

          # The command builtin allows one to alias nnn to n, if desired, without
          # making an infinitely recursive alias
          command nnn "$@"

          [ ! -f "$NNN_TMPFILE" ] || {
              . "$NNN_TMPFILE"
              rm -f -- "$NNN_TMPFILE" > /dev/null
          }
      }

      lfcd () {
          # `command` is needed in case `lfcd` is aliased to `lf`
          cd "$(command lf -print-last-dir "$@")"
      }
    '';
  };
}
