{ pkgs, ...}: {

home.package = [
pkgs.kitty
];

  program.kitty.enable = true;
  programs = {
    kitty = {
      setting = {
        cremember_window_size = true;
        initial_window_width = 640;
        initial_window_height = 400;
        confirm_os_window_close = 0;
        background_opacity = 0.5;
      };
    };
  };
}
