{
  username,
  pkgs,
  ...
}: {
  ##  networking.firewall.allowedTCPPorts = [65010];
  services = {
    cron = {
      enable = true;
      # systemCronJobs =[
      #       "*/5 * * * *   root date >> /tmp/cron.log"
      #   ];
    };
  };
  environment.systemPackages = with pkgs; [
  ];

  users.users.${username}.extraGroups = ["i2c"];
  #hardware.keyboard.zsa.enable = true;

  programs = {
    bash = {
      interactiveShellInit = ''
        # "check if parent process is not fish" && "make nested shells work properly"
        if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
            # set $SHELL for better integration with programs like nix shell, tmux, etc.
            SHELL=${pkgs.fish}/bin/fish exec fish
        fi '';
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };

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
  };
}
