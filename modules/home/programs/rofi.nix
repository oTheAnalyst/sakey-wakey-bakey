{ inputs, lib, ... }:
# home.nix
{

  xdg.configFile."rofi/config.rasi" = {
    source = ./config.rasi;
  };

  xdg.configFile."rofi" = {
    source = "${inputs.rofi}/files";
    recursive = true;
  };

}
