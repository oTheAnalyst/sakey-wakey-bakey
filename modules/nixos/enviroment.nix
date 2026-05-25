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
    # dependency for NH
    ############
     nix-output-monitor # Monitor Nix builds with progress bars
     nvd # Nix package version diff tool
    
    ############
    # latex dependencies
    ############
      texliveFull # Complete LaTeX distribution
      texliveTeTeX # Legacy TeTeX distribution (obsolete)
      texstudio # Feature-rich LaTeX editor
      texlivePackages.enumitem # LaTeX package for customizing lists
    
    #####
    # cli tools & general tools
    #####
      inputs.nixos-stable.legacyPackages.${pkgs.system}.qbittorrent # BitTorrent stable version client with CLI and GUI
      (pkgs.callPackage ./shadps4Practice.nix {}) # Custom PS4 emulator package
      unzip # Extract ZIP archives
      unrar # Extract RAR archives
      zip # Create ZIP archives
      cava # Console-based audio visualizer
      lolcat # Rainbow coloring for text output
      ani-cli # CLI tool to browse and watch anime
      microfetch # System information fetch tool
      proton-vpn # ProtonVPN client
      fzf # Fuzzy finder for command-line
      ripgrep # Fast line-oriented search tool
      pastel # Color manipulation and conversion tool
      tor # Anonymity network software
      rmpc # Remote Music Player Client (MPD client)
      dmidecode # Hardware information reporting tool
      gpart # Guess PC disk partition table
      wget # Network downloader
      distrobox # Run any Linux distro in a container
      podman # Daemonless container engine
      steam-run # Run Steam games with dependencies
      nix-prefetch-git # Prefetch git repositories for Nix
      tree # Display directory structure
      bat # Cat clone with syntax highlighting
      btop # System resource monitor
      wine # Run Windows applications on Linux
      git # Distributed version control system
      piper # GUI for configuring gaming mice
      libratbag # Driver for gaming mice configuration
      libreoffice # Office productivity suite
    
    ############
    ## neovim deps
    ############
      (import ./wifi-menu.nix {inherit pkgs;}) # Custom WiFi network menu
      rustup # Rust toolchain installer
      cargo # Rust package manager
      neovim # Hyperextensible Vim-based text editor
    
    ############
    ## lsp clients
    ############
      nil # Nix language server
      pyright # Python type checker and language server
      sqls # SQL language server
    
    ############
    # utility
    ############
      cups # Printing system
      gutenprint # High-quality printer drivers
      hplip # HP printer drivers
      docker-compose # Multi-container Docker applications
      quickemu # Quick VM creation and management
      pgcli # Postgres CLI with autocompletion
      keymapp # Keyboard mapping tool
      syncthing # Continuous file synchronization
      dbeaver-bin # Universal database client
      nix-init # Generate Nix packages from URLs
    
    ############
    # apps
    ############
      chromium # Web browser
      zathura # Lightweight PDF viewer
      vesktop # Custom Discord client
      discord # Voice and text chat app
      signal-desktop # Encrypted messaging app
      tor-browser # Privacy-focused browser
      zellij # Terminal multiplexer
      mangohud # Vulkan/OpenGL overlay for FPS
      veracrypt # Disk encryption software
      obsidian # Markdown knowledge base
      obs-studio # Video recording and streaming
      vlc # Media player
      shotcut # Video editor
      input-remapper # Remap input devices
      bitwarden-desktop # Password manager
    
    ############
    # hyprland apps
    ############
      kdePackages.gwenview # KDE image viewer
      xdg-desktop-portal-gtk # Portal interface for GTK
      walker # Application launcher
      rainfrog # Database GUI (note: not in nixpkgs)
      wttrbar # Weather widget for Wayland bars
      yazi # Blazing fast terminal file manager
      ueberzugpp # Image previewer for terminal
      brightnessctl # Control backlight brightness
      hyprshot # Screenshot tool for Hyprland
      playerctl # MPRIS media player controller
      grim # Screenshot tool for Wayland
      slurp # Select region for screenshots
      swappy # Screenshot editor
      gammastep # Adjust color temperature
      pavucontrol # PulseAudio volume control
      wlogout # Wayland logout menu
      libnotify # Desktop notifications library
      swaynotificationcenter # Notification daemon for Wayland
      rofi # Window switcher and launcher
      rofi-bluetooth # Bluetooth control for Rofi
      hypridle # Idle management for Hyprland
      hyprpaper # Wallpaper daemon for Hyprland
      hyprlock # Lock screen for Hyprland
      awww # Note: Package not found in nixpkgs  
      ];
}
