_: {
  programs.fish = {
    enable = true; # Enable bash
    shellAliases = {
      # Add useful shell aliases
      PATH = "$PATH :/home/pretender/.cargo/bin/";
      vflake = "nix run --no-write-lock-file github:oTheAnalyst/neovim-flake";
      ovim = "nix run github:Nobbz/nobbz-vim";
      gst = builtins.trace "hello world" "git status";
      gp = "git pull --rebase";
      ga = "git pull --abort";
      chm = "journalctl --user -e";
      mynix = "cd ~/sakey-wakey-bakey/ && tree && git status";
      vm_w11 = "cd ~/sakey-wakey-bakey/ && quickemu --vm windows-10.conf";
      vpn-connect = "sudo protonvpn connect --cc US";
      disconnect-vpn = "sudo protonvpn disconnect";
    };
    shellInit = "microfetch";
  };
}
