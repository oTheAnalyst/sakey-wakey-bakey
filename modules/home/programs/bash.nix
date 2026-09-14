{pkgs, ...}: {
  programs = {
    zellij = {
      enable = true;
      settings = {
        default_shell = "fish";
      };
    };
    nix-your-shell = {
      enable = true;

      # Optional: Enable for selected shells. Default: `home.shell.enable<Shell>Integration`.
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;

      # Optional: Whether to pipe the build output through nix-output-monitor. Default: false.
      nix-output-monitor.enable = false;
    };
    fish = {
      enable = true; # Enable bash
      interactiveShellInit = ''
        set fish_greeting
      '';
      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
      ];
      shellAliases = {
        # Add useful shell aliases
        PATH = "$PATH :/home/pretender/.cargo/bin/";
        vflake = "nix run --no-write-lock-file github:oTheAnalyst/neovim-flake";
        ovim = "nix run github:Nobbz/nobbz-vim";
        gp = "git pull --rebase";
        ga = "git pull --abort";
        chm = "journalctl --user -e";
        nvf = "nvim";
        mynix = "cd ~/sakey-wakey-bakey/ && tree -dtC && git status";
        vm_w11 = "cd ~/sakey-wakey-bakey/ && quickemu --vm windows-10.conf";
        vpn-connect = "sudo protonvpn connect --cc US";
        disconnect-vpn = "sudo protonvpn disconnect";
      };
    };
  };
}
