_: {
  programs = {
    home-manager = true;
    starship.enable = true;
    starship.settings = {
      charecter = {
        NixOS = " ";
        rlang = "󰟔 ";
        git_branch = " ";
        nix_shell = " ";
      };
    };
  };
}
