{ config, ... }:
{
  programs.carapace = {
    enable = true;
    enableFishIntegration = false;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      g = "git";
      cd = "z";
      cdi = "zi";
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      music = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'release_year:%(date)s' --parse-metadata 'album:%(album)s' --parse-metadata 'playlist_index:%(track_number)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/%(artists.0,channel,uploader)s/%(release_year)s - %(artists.0,channel,uploader)s - %(album)s/%(track_number,playlist_index)s - %(artists.0,channel,uploader)s - %(title).200B.%(ext)s'";
      # music = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/%(uploader)s - %(title)s.%(ext)s'";
      album = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/%(uploader)s - %(playlist)s/%(track_number,playlist_index)s - %(title)s.%(ext)s'";
      playlist = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --parse-metadata 'artist:%(artist)s' --parse-metadata 'album_artist:%(albumartist)s' --parse-metadata 'artist:%(artist)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/Mixes/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'";
      video = "yt-dlp --embed-metadata --output '${config.home.homeDirectory}/Videos/Youtube/%(title).200B.%(ext)s'";
      cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
    };
    settings = {
      show_banner = false;
      buffer_editor = "vi";
    };
    envFile.text = ''
      $env.CARAPACE_BRIDGES = 'fish,inshellisense'
    '';
    configFile.text = ''
      $env.config.table.mode = 'single'
      let abbreviations = {
          "cd..": 'cd ..'
          sau: 'sudo apt update; sudo apt upgrade'
          bu: 'brew update; brew upgrade'
      }

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
