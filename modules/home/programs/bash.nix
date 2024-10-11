_:

{

  programs.bash = {
    enable = true;              # Enable bash
    enableCompletion = true;    # Enable bash completion
    historyFileSize = 50000;    # Set the size of bash history
    historyFile = ".bash_history";

    shellAliases = {
      # Add useful shell aliases
    vflake="nix run github:jordanisaacs/neovim-flake";
    gst = builtins.trace "hello world" "git status";
    gp = "git pull";
    };
   };
  }
