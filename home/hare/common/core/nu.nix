{ config, ... }:
{
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enableNushellIntegration = true;
    };

    eza = {
      enableNushellIntegration = true;
    };

    zoxide = {
      enableNushellIntegration = true;
    };
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      cd = "z";
      cdi = "zi";
      ci = "zi";
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      v = "vimiv";
      view = "vimiv";
      e = "nvim";
      edit = "nvim";
      y = "yazi";
    };

    settings = {
      show_banner = false;
      buffer_editor = "vi";
    };

    envFile.text = ''
      $env.CARAPACE_BRIDGES = 'fish,inshellisense'
      $env.TRANSIENT_PROMPT_COMMAND = ^starship module character
    '';

    configFile.text = ''
      $env.config.table.mode = 'single'
      let abbreviations = {
          "cd..": 'cd ..'
          sau: 'sudo apt update; sudo apt upgrade'
          bu: 'brew update; brew upgrade'
      }

      $env.config.keybindings ++= [{
          name: tmux_sessionizer
          modifier: control
          keycode: char_f
          mode: [emacs, vi_normal, vi_insert]
          event: [
              { edit: Clear }
              {
                edit: InsertString,
                value: "tms"
              }
              { send: Enter }
          ]
      }]

      $env.config.keybindings ++= [{
          name: tmux_sessionizer
          modifier: control
          keycode: char_t
          mode: [emacs, vi_normal, vi_insert]
          event: [
              { edit: Clear }
              {
                edit: InsertString,
                value: "tms switch"
              }
              { send: Enter }
          ]
      }]

      $env.config = {
          keybindings: [
            {
              name: abbr_menu
              modifier: none
              keycode: enter
              mode: [emacs, vi_normal, vi_insert]
              event: [
                  { send: menu name: abbr_menu }
                  { send: enter }
              ]
            }
            {
              name: abbr_menu
              modifier: none
              keycode: space
              mode: [emacs, vi_normal, vi_insert]
              event: [
                  { send: menu name: abbr_menu }
                  { edit: insertchar value: ' '}
              ]
            }
          ]

          menus: [
              {
                  name: abbr_menu
                  only_buffer_difference: false
                  marker: none
                  type: {
                      layout: columnar
                      columns: 1
                      col_width: 20
                      col_padding: 2
                  }
                  style: {
                      text: green
                      selected_text: green_reverse
                      description_text: yellow
                  }
                  source: { |buffer, position|
                      let match = $abbreviations | columns | where $it == $buffer
                      if ($match | is-empty) {
                          { value: $buffer }
                      } else {
                          { value: ($abbreviations | get $match.0) }
                      }
                  }
              }
          ]
      }
    '';
  };
}
