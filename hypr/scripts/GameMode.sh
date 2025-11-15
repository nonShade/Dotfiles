#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode - Optimized Performance Toggle
# Switches between regular desktop and gaming-optimized settings

# =============================================================================
# CONFIGURATION VARIABLES
# =============================================================================
notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Gaming mode settings (optimized for performance)
GAME_GAPS_IN=0
GAME_GAPS_OUT=0
GAME_BORDER_SIZE=1
GAME_ROUNDING=0

# =============================================================================
# FUNCTIONS
# =============================================================================
enable_game_mode() {
    echo "Enabling game mode..."
    
    # Apply performance-optimized settings
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in $GAME_GAPS_IN;\
        keyword general:gaps_out $GAME_GAPS_OUT;\
        keyword general:border_size $GAME_BORDER_SIZE;\
        keyword decoration:rounding $GAME_ROUNDING"
    
    # Override all window opacity to 1.0 for maximum performance
    hyprctl keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
    
    # Stop wallpaper daemon to save resources
    swww kill 
    
    notify-send -e -u low -i "$notif" " Game Mode:" " Enabled - Performance Optimized"
}

disable_game_mode() {
    echo "Disabling game mode..."
    
    # Restart wallpaper daemon and apply current wallpaper
    swww-daemon --format xrgb && swww img "$HOME/.config/rofi/.current_wallpaper" &
    sleep 0.1
    
    # Reapply wallust color scheme
    ${SCRIPTSDIR}/WallustSwww.sh
    sleep 0.5
    
    # Refresh all UI components to restore normal settings
    ${SCRIPTSDIR}/Refresh.sh
    
    notify-send -e -u normal -i "$notif" " Game Mode:" " Disabled - Normal Mode Restored"
}

# =============================================================================
# MAIN LOGIC
# =============================================================================
# Check current animation state to determine if game mode is active
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = 1 ] ; then
    enable_game_mode
else
    disable_game_mode
fi

exit 0
