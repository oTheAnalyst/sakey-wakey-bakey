{
  programs = {
    kitty = {
      enable = true;
      font.name = "nerd-fonts-fira-code";
      extraConfig = ''
        cremember_window_size  no
        initial_window_width  640
        initial_window_height  400
        confirm_os_window_close  0
        background_opacity  0.8
        hide_window_decorations  yes
      '';
    };
  };
}
