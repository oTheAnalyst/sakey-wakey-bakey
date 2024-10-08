_: {
  programs = {
    home-manager = true;
    kitty.enable = true;
    kitty = {
      enviroment = ''
        cremember_window_size  yes
        initial_window_width  640
        initial_window_height 400
        confirm_os_window_close 0
        background_opacity 0.5
      '';
    };
  };
}
