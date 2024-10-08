_: {
  programs = {
    home-manager = true;
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
