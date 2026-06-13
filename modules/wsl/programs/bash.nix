{pkgs, ...}: {
  programs.fish = {
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
      gst = builtins.trace "hello world" "git status";
      gp = "git pull --rebase";
      ga = "git pull --abort";
      chm = "journalctl --user -e";
      mynix = "cd ~/sakey-wakey-bakey/ && tree && git status";
      vpn-connect = "sudo protonvpn connect --cc US";
      disconnect-vpn = "sudo protonvpn disconnect";
    };
  };
}
