{
  username,
  user3,
  sub,
  pkgs,
  ...
}: {
  networking.firewall.allowedTCPPorts = [65010];
  services = {
    qbittorrent.enable = true;
    flatpak = {
      enable = true;
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      packages = [
        "com.teamspeak.TeamSpeak3"
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    ipp-usb.enable = true;
    tailscale.enable = true;
    cron = {
      enable = true;
      # systemCronJobs =[
      #       "*/5 * * * *   root date >> /tmp/cron.log"
      #   ];
    };
  };
  environment.systemPackages = with pkgs; [
    ddcutil
  ];
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  boot.kernelModules = ["i2c-dev" "ddcci-driver-linux"];

  users.groups.i2c = {};

  users.users.${sub} = {
    isNormalUser = true;
    description = sub;
    extraGroups = ["networkmanager" "i2c" "wheel"];
  };

  users.users.${user3} = {
    isNormalUser = true;
    description = user3;
    extraGroups = ["networkmanager" "i2c" "wheel"];
  };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "i2c" "wheel"];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
    fira-code-symbols
    nerd-fonts.droid-sans-mono
  ];

  hardware.keyboard.zsa.enable = true;
  programs = {
    neovim.defaultEditor = true;
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
    waybar.enable = false;
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

  xdg = {
    menus = {
      enable = true;
    };
    #    config.files = {
    #      "waybar/config.jsonc".source = ./config.jsonc;
    #      "waybar/style.css".source = ./style.css;
    mime = {
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
  };
}
