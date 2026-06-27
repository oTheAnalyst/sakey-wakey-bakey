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
      vflake = "nix run --no-write-lock-file github:oTheAnalyst/neovim-flake";
      ovim = "nix run github:Nobbz/nobbz-vim";
      gst = builtins.trace "hello world" "git status";
      gp = "git pull --rebase";
      ga = "git pull --abort";
      chm = "journalctl --user -e";
      nvf = "nix run /home/pretender/Public/bakey-wakey";
      mynix = "cd ~/sakey-wakey-bakey/ && tree -dtC && git status";
      vm_w11 = "cd ~/sakey-wakey-bakey/ && quickemu --vm windows-10.conf";
      vpn-connect = "sudo protonvpn connect --cc US";
      disconnect-vpn = "sudo protonvpn disconnect";
    };
  };
}
