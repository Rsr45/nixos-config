#!/usr/bin/env bash
# Wallpaper selecting script that uses swww to change the wallpaper and can set pywal colors as well.

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/wallpapers"

# Rofi config path
rofiDIR="$HOME/.config/rofi/config-wallpaper.rasi"

# Transition config
FPS=30
TYPE="wipe"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Check if swaybg is running
if pidof swaybg >/dev/null; then
	pkill swaybg
fi

# Retrieve image files
PICS=($(ls "${wallDIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))
RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME="${#PICS[@]}. random"

# Rofi command change the config directory
rofi_command="wofi -show -dmenu " #-config "${rofiDIR}""

menu() {
	for i in "${!PICS[@]}"; do
		# Displaying .gif to indicate animated images
		if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
			printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${PICS[$i]}\n"
		else
			printf "${PICS[$i]}\n"
		fi
	done

	printf "$RANDOM_PIC_NAME\n"
}

swww query || swww-daemon

main() {
	choice=$(menu | ${rofi_command})

	# No choice case
	if [[ -z $choice ]]; then
		exit 0
	fi

	# Random choice case
	if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
		swww img "${wallDIR}/${RANDOM_PIC}" $SWWW_PARAMS
		exit 0
	fi

	# Find the index of the selected file
	pic_index=-1
	for i in "${!PICS[@]}"; do
		filename=$(basename "${PICS[$i]}")
		if [[ "$filename" == "$choice"* ]]; then
			pic_index=$i
			break
		fi
	done

	if [[ $pic_index -ne -1 ]]; then
		swww img "${wallDIR}/${PICS[$pic_index]}" $SWWW_PARAMS
	else
		echo "Image not found."
		exit 1
	fi
}

# Check if rofi is already running
if pidof rofi >/dev/null; then
	pkill rofi
	exit 0
fi

main

# Combine the second script
# Pywal Colors for current wallpaper

# Define the path to the swww cache directory
cache_dir="$HOME/.cache/swww/"

# Get a list of monitor outputs
monitor_outputs=($(ls "$cache_dir"))

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Get first valid monitor
current_monitor=$(hyprctl -j monitors | jq -r '.[0].name')

# Construct the full path to the cache file
cache_file="$cache_dir$current_monitor"

# Check if the cache file exists for the current monitor output
if [ -f "$cache_file" ]; then
	# Get the wallpaper path from the cache file
	wallpaper_path=$(cat "$cache_file")

	# Copy the wallpaper to the location Rofi can access
	if ln -sf "$wallpaper_path" "$HOME/.cache/.current_wallpaper"; then
		ln_success=true # Set the flag to true upon successful execution
	fi
fi

# Check the flag before executing further commands
if [ "$ln_success" = true ]; then
	# execute pywal
	wal -i "$wallpaper_path"
fi
