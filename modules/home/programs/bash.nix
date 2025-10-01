_: {
  programs.bash = {
    enable = true; # Enable bash
    enableCompletion = true; # Enable bash completion
    historyFileSize = null; # Set the size of bash history
    historyFile = ".bash_history";

    shellAliases = {
      # Add useful shell aliases
      PATH = "$PATH :/home/pretender/.cargo/bin/";
      vflake = "nix run --no-write-lock-file github:oTheAnalyst/neovim-flake";
      ovim = "nix run github:Nobbz/nobbz-vim";
      gst = builtins.trace "hello world" "git status";
      gp = "git pull";
      chm = "journalctl --user -e";
      mynix = "cd ~/sakey-wakey-bakey/ && tree && git status";
      vpn-connect = "sudo protonvpn connect --cc US";
      disconnect-vpn = "sudo protonvpn disconnect";
    };
    bashrcExtra = "microfetch";
  };
}
