#!/usr/bin/env bash

case "$1" in
  "symbol")
    wpctl status --monitor | while read -r line; do
      case "$(wpctl get-default-sink)" in
        *Arctis_9*) echo "";;   # headset icon
        *)          echo "";;   # speaker icon
      esac
    done
    ;;

  "volume")
    get_volume() {
      # Example output: "Volume: 0.52 [52%] Mute: false"
      wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oP '\[\K[0-9]+(?=%\])'
    }

    get_volume
    wpctl status --monitor | grep --line-buffered "Audio/Sink" | while read -r; do
      get_volume
    done
    ;;

  "toggle")
    speaker_sink_id=$(wpctl status | grep -A1 "Komplete_Audio_6" | head -n1 | awk '{print $1}' | tr -d '.')
    game_sink_id=$(wpctl status | grep -A1 "stereo-game" | head -n1 | awk '{print $1}' | tr -d '.')

    case "$(wpctl get-default-sink)" in
      *Arctis_9*)
        eww -c ~/.config/eww-bar update audio_sink=""
        wpctl set-default "$speaker_sink_id"
        ;;
      *)
        eww -c ~/.config/eww-bar update audio_sink=""
        wpctl set-default "$game_sink_id"
        ;;
    esac
    ;;
esac
