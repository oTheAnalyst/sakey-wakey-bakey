_: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
    "opener.open".run = ''xdg-open "$@"'';
      opener.open = {
        desc = "Open";
      };
    };
  };
}

