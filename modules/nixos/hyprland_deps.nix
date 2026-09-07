{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############
    # hyprland apps
    ############
    waybar
    kdePackages.gwenview # KDE image viewer
    xdg-desktop-portal-gtk # Portal interface for GTK
    walker # Application launcher
    rainfrog # Database GUI (note: not in nixpkgs)
    wttrbar # Weather widget for Wayland bars
    ueberzugpp # Image previewer for terminal
    brightnessctl # Control backlight brightness
    hyprshot # Screenshot tool for Hyprland
    playerctl # MPRIS media player controller
    grim # Screenshot tool for Wayland
    slurp # Select region for screenshots
    swappy # Screenshot editor
    gammastep # Adjust color temperature
    pavucontrol # PulseAudio volume control
    wlogout # Wayland logout menu
    libnotify # Desktop notifications library
    swaynotificationcenter # Notification daemon for Wayland
    rofi # Window switcher and launcher
    rofi-bluetooth # Bluetooth control for Rofi
    hypridle # Idle management for Hyprland
    hyprpaper # Wallpaper daemon for Hyprland
    hyprlock # Lock screen for Hyprland
    awww # Note: Package not found in nixpkgs
  ];
}
