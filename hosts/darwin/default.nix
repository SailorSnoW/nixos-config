{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
{
  # Primary user for system.defaults and homebrew
  system.primaryUser = "snow";

  # Nix configuration
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "snow"
      ];
      # Better download performance
      http-connections = 50;
      warn-dirty = false;
      accept-flake-config = true;
    };

    # Auto optimise store
    optimise.automatic = true;

    # Garbage collection
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  # Nixpkgs config
  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-darwin";
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.nur.overlays.default
    ];
  };

  # User configuration
  users.users.snow = {
    name = "snow";
    home = "/Users/snow";
    shell = pkgs.zsh;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    coreutils
    gnused
    gawk
    gnugrep
    findutils
    tmux
    neovim
    direnv
    btop
    jq
    ripgrep
    yq
    docker-compose
  ];

  # Programs
  programs.zsh.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    inter
  ];

  # macOS system defaults - optimized for development
  system.defaults = {
    # Global domain
    NSGlobalDomain = {
      # Keyboard
      AppleKeyboardUIMode = 3; # Full keyboard control
      ApplePressAndHoldEnabled = false; # Key repeat instead of accents
      InitialKeyRepeat = 15; # Faster initial key repeat
      KeyRepeat = 2; # Faster key repeat rate
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # Mouse/Trackpad
      AppleShowScrollBars = "WhenScrolling";
      NSScrollAnimationEnabled = true;
      "com.apple.swipescrolldirection" = true; # Natural scrolling
      "com.apple.trackpad.forceClick" = true;
      "com.apple.trackpad.scaling" = 0.875;

      # Finder
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;

      # UI
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      NSWindowResizeTime = 0.001; # Faster window resize
      _HIHideMenuBar = false;
    };

    # Dock
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      expose-animation-duration = 0.1;
      tilesize = 48;
      launchanim = false;
      static-only = false;
      show-recents = false;
      show-process-indicators = true;
      orientation = "bottom";
      mru-spaces = false; # Don't rearrange spaces based on recent use
    };

    # Finder
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowStatusBar = true;
      ShowPathbar = true;
      FXDefaultSearchScope = "SCcf"; # Search current folder
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv"; # List view
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };

    # Trackpad
    trackpad = {
      Clicking = false; # Tap to click disabled
      TrackpadRightClick = true; # Secondary click with two fingers
      TrackpadThreeFingerDrag = true;
      FirstClickThreshold = 1; # 0=light, 1=medium, 2=firm
      SecondClickThreshold = 1; # Force click threshold: medium
      ActuationStrength = 1; # Haptic feedback strength
    };

    # Screenshots
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;
    };

    # Spaces
    spaces = {
      spans-displays = false;
    };

    # Login window
    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    # Menu bar clock
    menuExtraClock = {
      Show24Hour = true;
      ShowSeconds = false;
    };

    # Custom user preferences
    CustomUserPreferences = {
      # Disable disk image verification
      "com.apple.frameworks.diskimages" = {
        skip-verify = true;
        skip-verify-locked = true;
        skip-verify-remote = true;
      };

      # Enable developer mode for Xcode
      "com.apple.dt.Xcode" = {
        ShowBuildOperationDuration = true;
      };

      # Terminal - Secure Keyboard Entry
      "com.apple.terminal" = {
        SecureKeyboardEntry = true;
      };

      # Activity Monitor - Show All Processes
      "com.apple.ActivityMonitor" = {
        OpenMainWindow = true;
        IconType = 5;
        ShowCategory = 0;
      };

      # Trackpad advanced settings
      "com.apple.AppleMultitouchTrackpad" = {
        ActuateDetents = 1; # Haptic feedback enabled
        ForceSuppressed = 0; # Force click enabled
      };

      # Prevent .DS_Store on network/USB volumes
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };

  # Keyboard remapping
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Security - Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Homebrew (for casks not available in nixpkgs)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    global = {
      brewfile = true;
    };
    taps = [ ];
    brews = [
      "protobuf"
    ];
    casks = [
      "docker-desktop"
    ];
  };

  # System state version
  system.stateVersion = 5;
}
