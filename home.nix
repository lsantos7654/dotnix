{ config, pkgs, ... }:

{
  home.username = "santos";
  home.homeDirectory = "/home/santos";
  home.stateVersion = "25.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # ============================================================================
  # PACKAGES
  # ============================================================================
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.hack

    # Terminal utilities
    wl-clipboard    # Wayland clipboard (wl-copy, wl-paste)
    ripgrep         # Fast grep (for telescope)
    fd              # Fast find (for telescope)
    fzf             # Fuzzy finder
    lazygit         # Git TUI
    bat             # Better cat

    # Neovim dependencies
    nodejs          # For LSP servers
    python3         # For various plugins
    gcc             # For treesitter compilation
    gnumake
    unzip           # For Mason
    cargo           # For some LSP servers
    luajit          # Lua runtime
    luarocks        # Lua package manager

    # LSP servers (can also be managed by Mason, but Nix is more reliable)
    lua-language-server
    nil             # Nix LSP
    pyright         # Python LSP
    nodePackages.typescript-language-server
  ];

  # ============================================================================
  # ZSH
  # ============================================================================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      v = "nvim";
      g = "git";
      lg = "lazygit";
      ll = "ls -la";
      ".." = "cd ..";
    };

    initExtra = ''
      # Add any custom zsh config here
      export EDITOR=nvim
    '';
  };

  # ============================================================================
  # KITTY
  # ============================================================================
  programs.kitty = {
    enable = true;
    font = {
      name = "Hack Nerd Font";
      size = 15;
    };
    settings = {
      # From your existing config
      hide_window_decorations = "titlebar-only";
      dynamic_background_opacity = "yes";
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
      enable_audio_bell = "no";
      term = "xterm-256color";
      macos_option_as_alt = "both";

      # Solarized Dark Higher Contrast theme (from your theme.conf)
      background = "#001e26";
      foreground = "#9bc1c2";
      cursor = "#f34a00";
      selection_background = "#003747";
      selection_foreground = "#001e26";
      color0 = "#002731";
      color8 = "#006388";
      color1 = "#d01b24";
      color9 = "#f4153b";
      color2 = "#6bbe6c";
      color10 = "#50ee84";
      color3 = "#a57705";
      color11 = "#b17e28";
      color4 = "#2075c7";
      color12 = "#178dc7";
      color5 = "#c61b6e";
      color13 = "#e14d8e";
      color6 = "#259185";
      color14 = "#00b29e";
      color7 = "#e9e2cb";
      color15 = "#fcf4dc";
    };
  };

  # ============================================================================
  # TMUX
  # ============================================================================
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    prefix = "C-Space";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      # minimal-tmux-status not in nixpkgs - using minimal styling in extraConfig
    ];

    extraConfig = ''
      # Window navigation
      bind -n M-H previous-window
      bind -n M-L next-window

      # Pane settings
      set -g pane-base-index 1
      set -g allow-passthrough on
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Terminal features for true color
      set-option -a terminal-features 'xterm-256color:RGB'

      # Clipboard settings (Wayland)
      set-option -g set-clipboard off
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

      # Toggle status bar
      bind-key b set-option status

      # Alt+number window switching
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # Window/pane management
      bind-key r command-prompt -I "#W" "rename-window '%%'"
      bind-key x kill-pane
      bind-key X kill-window

      # Splits (open in current path)
      bind h split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"

      # Swap panes
      bind-key j swap-pane -D
      bind-key k swap-pane -U

      # Swap windows
      bind-key H swap-window -t -1\; select-window -t -1
      bind-key L swap-window -t +1\; select-window -t +1

      # Move window to position
      bind-key M-1 swap-window -t 1
      bind-key M-2 swap-window -t 2
      bind-key M-3 swap-window -t 3
      bind-key M-4 swap-window -t 4
      bind-key M-5 swap-window -t 5
      bind-key M-6 swap-window -t 6
      bind-key M-7 swap-window -t 7
      bind-key M-8 swap-window -t 8
      bind-key M-9 swap-window -t 9

      # Join pane
      bind u command-prompt -p "join-pane to window:" "join-pane -h -t %%"

      # Minimal status bar styling (replacement for minimal-tmux-status)
      set -g status-style "bg=default,fg=white"
      set -g status-left ""
      set -g status-right "#[fg=brightblack]#S"
      set -g status-justify left
      set -g window-status-format "#[fg=brightblack] #I #W "
      set -g window-status-current-format "#[fg=white,bold] #I #W "
      set -g status-position bottom
    '';
  };

  # ============================================================================
  # NEOVIM
  # ============================================================================
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Symlink your existing neovim config
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/santos/project/dotnvim";
  };

  # ============================================================================
  # GIT (basic config)
  # ============================================================================
  programs.git = {
    enable = true;
    userName = "Lucas Santos";  # Update if needed
    # userEmail = "your@email.com";  # Uncomment and set
  };
}
