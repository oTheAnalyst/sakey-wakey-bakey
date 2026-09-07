{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ############
    # custom utility
    ############
    (btop.override {rocmSupport = true;}) # Resource monitor with GPU support

    ############
    # Nix tools Expanded
    ############
    nix-prefetch-git # Prefetch git repositories for Nix
    nix-tree #app for trouble shooting dependency issue
    nix-init # Generate Nix packages from URLs
    devenv #declaritve deployment

    ############
    # dependency for NH
    ############
    nix-output-monitor # Monitor Nix builds with progress bars
    nvd # Nix package version diff tool

    ############
    # latex dependencies
    ############
    #texliveFull # Complete LaTeX distribution
    # texliveTeTeX # Legacy TeTeX distribution (obsolete)
    # texlivePackages.enumitem # LaTeX package for customizing lists

    #####
    # cli tools & general tools
    #####
    inputs.nixos-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qbittorrent # BitTorrent stable version client with CLI and GUI
    (pkgs.callPackage ./shadps4Practice.nix {}) # Custom PS4 emulator package
    grc #Generic text colouriser used with fish hm plugin
    unzip # Extract ZIP archives
    unrar # Extract RAR archives
    zip # Create ZIP archives
    trash-cli # cli tool for trashcan
    cava # Console-based audio visualizer
    lolcat # Rainbow coloring for text output
    (ani-cli.overrideAttrs (old: rec {
      pname = "ani-cli";
      version = "5.0";
      __structuredAttrs = true;
      strictDeps = true;

      src = fetchFromGitHub {
        owner = "pystardust";
        repo = "ani-cli";
        tag = "v5.0";
        hash = "sha256-rRQESi0Skoyf1jy/dRRK6ooKRPQhkak107kk5ulwZYI=";
      };
    }))

    microfetch # System information fetch tool
    proton-vpn # ProtonVPN client
    fzf # Fuzzy finder for command-line
    ripgrep # Fast line-oriented search tool
    pastel # Color manipulation and conversion tool
    tor # Anonymity network software
    #rmpc # Remote Music Player Client (MPD client)
    #dmidecode # Hardware information reporting tool
    #gpart # Guess PC disk partition table
    wget # Network downloader
    podman # Daemonless container engine
    steam-run # Run Steam games with dependencies
    tree # Display directory structure
    lazygit #simple terminal UI for git commands
    bat # Cat clone with syntax highlighting
    btop # System resource monitor
    wine # Run Windows applications on Linux
    git # Distributed version control system
    piper # GUI for configuring gaming mice
    libratbag # Driver for gaming mice configuration
    #libreoffice # Office productivity suite

    ############
    ## neovim deps
    ############
    (import ./wifi-menu.nix {inherit pkgs;}) # Custom WiFi network menu
    inputs.bakey-wakey.packages.${pkgs.stdenv.hostPlatform.system}.default

    ############
    ## lsp clients
    ############
    nil # Nix language server
    pyright # Python type checker and language server
    sqls # SQL language server

    ############
    # utility
    ############
    wl-clipboard #copy paste utility
    cups # Printing system
    gutenprint # High-quality printer drivers
    hplip # HP printer drivers
    docker-compose # Multi-container Docker applications
    quickemu # Quick VM creation and management
    pgcli # Postgres CLI with autocompletion
    syncthing # Continuous file synchronization
    dbeaver-bin # Universal database client

    ############
    # apps
    ############
    chromium # Web browser
    zathura # Lightweight PDF viewer
    vesktop # Custom Discord client
    equibop # another performat discord client
    signal-desktop # Encrypted messaging app
    tor-browser # Privacy-focused browser
    zellij # Terminal multiplexer
    mangohud # Vulkan/OpenGL overlay for FPS
    veracrypt # Disk encryption software
    obsidian # Markdown knowledge base
    obs-studio # Video recording and streaming
    vlc # Media player
    #shotcut # Video editor
    input-remapper # Remap input devices
    bitwarden-desktop # Password manager
  ];
}
