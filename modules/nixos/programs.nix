{
  services = {
    tailscale.enable = true;
    cron = {
      enable = true;
      # systemCronJobs =[
      #       "*/5 * * * *   root date >> /tmp/cron.log"
      #   ];
    };
  };
hardware.keyboard.zsa.enable = true;
  programs = {
    firefox.enable = true;
    hyprland.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
    git = {
      config = [
        "
[safe]
  directory = /etc/nixos
	directory = /etc/nixos
[init]
	defaultBranch = main
[user]
	email = michaelvcumbo21@proton.me
	name = VtheRtech
[maintenance]
	repo = /home/pretender/Public/nixpkgs
[core]
	editor = nvim
  "
      ];
    };
    openvpn3.enable = false;
    virt-manager.enable = true;
    waybar.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        nix_shell = {
          symbol = " ";
          format = "$symbol ";
        };
        hostname.format = "$hostname:";
        username.format = "$user@";
      };
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  xdg.menus.enable = true;
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["zathura.desktop"];
      "directory" = ["gwenview.desktop"];
      "image/png" = [
        "sxiv.desktop"
        "gimp.desktop"
      ];
    };
  };

}
