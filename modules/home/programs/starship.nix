_: {
  programs = {
    home-manager = true;
    kitty = {
      enable = true;
      enviroment = ''
        cremember_window_size  yes
        initial_window_width  640
        initial_window_height 400
        confirm_os_window_close 0
        background_opacity 0.5
      '';
    };
    starship = {
    enable = true;
    settings = {
      charecter = {
        NixOS = " ";
        rlang = "󰟔 ";
        git_branch = " ";
        nix_shell = " ";
          };
      };
    };
  };
}
