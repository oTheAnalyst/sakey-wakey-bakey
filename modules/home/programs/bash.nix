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
      gp = "git pull --rebase";
      ga = "git pull --abort";
      lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      lg = "lg1";
      chm = "journalctl --user -e";
      mynix = "cd ~/sakey-wakey-bakey/ && tree && git status";
      vpn-connect = "sudo protonvpn connect --cc US";
      disconnect-vpn = "sudo protonvpn disconnect";
    };
    bashrcExtra = "microfetch";
  };
}
