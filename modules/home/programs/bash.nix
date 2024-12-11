_:

{

  programs.bash = {
    enable = true;              # Enable bash
    enableCompletion = true;    # Enable bash completion
    historyFileSize = 50000;    # Set the size of bash history
    historyFile = ".bash_history";

    shellAliases = {
      # Add useful shell aliases
    vflake="nix run --no-write-lock-file github:oTheAnalyst/neovim-flake";
    gst = builtins.trace "hello world" "git status";
    gp = "git pull";
    bfu = "sudo nixos-rebuild switch --flake";
    };
   };
  }
