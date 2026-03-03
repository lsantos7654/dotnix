{ config, lib, pkgs, ... }:

{
  imports = [ ./plasma.nix ];
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
    eza             # Modern ls replacement
    zoxide          # Smarter cd
    glow            # Markdown renderer
    tree            # Directory tree
    uv              # Fast Python package manager
    google-cloud-sdk
    zsh-powerlevel10k

    # Neovim dependencies
    nodejs          # For LSP servers
    python3         # For various plugins
    gcc             # For treesitter compilation
    gnumake
    unzip           # For plugin installers
    cargo           # For some LSP servers
    luajit          # Lua runtime
    luarocks        # Lua package manager
  ];

  # ============================================================================
  # ZSH
  # ============================================================================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "fzf" ];
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # p10k instant prompt (must be at very top of .zshrc)
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '')
      ''
        # Environment
        export EDITOR=nvim
        export PATH=$HOME/.local/bin:$PATH
        export PATH="$PATH:$HOME/.luarocks/bin"
        export LUA_PATH="$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;$LUA_PATH"
        export LUA_CPATH="$HOME/.luarocks/lib/lua/5.1/?.so;$LUA_CPATH"

        # Source docker functions
        source "$HOME/.config/shell/docker_functions.bash"

        # ── Completions ──────────────────────────────────────────────────
        # Docker
        function _docker_all() {
          reply=($(docker ps -a --format '{{.Names}}'))
        }
        function _docker_on() {
          reply=($(docker ps --format '{{.Names}}'))
        }
        compctl -K _docker_all drm
        compctl -K _docker_on dkill
        compctl -K _docker_all drunning
        compctl -K _docker_all dzsh

        # Jupyter
        function _kernel_completions() {
          reply=($(jupyter kernelspec list | grep -v "Available" | awk '{print $1}'))
        }
        compctl -K _kernel_completions start_kernel
        compctl -K _kernel_completions delete_kernel

        # Gcloud
        _gcloud_completions() {
          local curcontext="$curcontext" state line
          typeset -A opt_args
          _arguments -C \
            "1:instances:($(gcloud compute instances list --format='value(name)'))" \
            "2:zones:($(gcloud compute zones list --format='value(name)'))" \
            "3:files:_files"
        }
        compdef _gcloud_completions gcloud_start
        compdef _gcloud_completions gcloud_stop
        compdef _gcloud_completions gcloud_enter
        compdef _gcloud_completions gcloud_copy

        # ── Functions ────────────────────────────────────────────────────
        function fuzzycd() {
          local file=$(find . -type f | fzf --query="$1" +m)
          if [ -n "$file" ]; then
            cd "$(dirname "$file")" || return
          fi
        }

        function bat_tail() {
          local lines=''${1:-10}
          local file
          if [[ -f $1 ]]; then
            file=$1
            lines=10
          else
            file=$2
          fi
          bat --line-range $(expr $(wc -l < "$file") - $lines): "$file"
        }

        function pwd_with_file() {
          current_dir=$(pwd)
          current_file=$(basename "$1")
          echo "''${current_dir}/''${current_file}"
        }

        function create_kernel() {
          if [ -z "$1" ]; then
            echo "Please specify a kernel name"
            return 1
          fi
          python -m ipykernel install --user --name=$1
        }

        function start_kernel() {
          jupyter kernel --kernel=$1
        }

        function delete_kernel() {
          if [ -z "$1" ]; then
            echo "Please specify a kernel to delete"
            return 1
          fi
          jupyter kernelspec uninstall "$1" -f
        }

        function open_nvim() {
          nvim .
        }
        zle -N open_nvim

        function clear_screen() {
          clear
          zle reset-prompt
        }
        zle -N clear_screen

        function follow_link() {
          builtin cd "$(dirname "$(readlink -f "$1")")"
        }

        function gcloud_start() {
          gcloud compute instances start $1 --zone $2
        }

        function gcloud_stop() {
          gcloud compute instances stop $1 --zone $2
        }

        function gcloud_copy() {
          local full_path
          full_path=$(realpath "$3")
          local base_name
          base_name=$(basename "$3")
          gcloud compute scp --recurse "$full_path" "$1:~/$base_name" --zone="$2"
        }

        function gcloud_enter() {
          gcloud compute ssh $1 --ssh-flag="-X" --ssh-flag="-L 8085:localhost:8085" --zone=$2
        }

        function docker_script() {
          local input_dir=$(realpath "$1")
          local output_dir=$(realpath "$2")
          local image="$3"
          docker run --rm -d -v "$input_dir:/input" -v "$output_dir:/output" "$image"
        }
        _docker_script_completions() {
          local curcontext="$curcontext" state line
          typeset -A opt_args
          _arguments -C \
            "1:files:_files" \
            "2:files:_files" \
            "3:images:($(docker images --format "{{.Repository}}:{{.Tag}}"))"
        }
        compdef _docker_script_completions docker_script

        # ── Keybindings ──────────────────────────────────────────────────
        bindkey '^n' open_nvim
        bindkey "^p" clear_screen
        bindkey "^[h" backward-word
        bindkey "^[l" vi-forward-word-end

        # ── Zoxide ───────────────────────────────────────────────────────
        eval "$(zoxide init --cmd cd zsh)"

        # ── Powerlevel10k ───────────────────────────────────────────────
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # ── Hivemind ─────────────────────────────────────────────────────
        _hivemind_completion() {
          eval $(env _TYPER_COMPLETE_ARGS="''${words[1,$CURRENT]}" _HIVEMIND_COMPLETE=complete_zsh hivemind)
        }

        compdef _hivemind_completion hivemind
      ''
    ];

    shellAliases = {
      # Editor
      v = "nvim";

      # Listing (eza)
      l = "eza -lh --icons=auto";
      ls = "eza -1 --icons=auto";
      la = "eza -lha --icons=auto --sort=name --group-directories-first";
      ld = "eza -lhD --icons=auto";
      lt = "tree -h --du ./";
      ll = "eza -lha --icons=auto";

      # Git
      g = "git";
      lg = "lazygit";
      gpull = "git stash && git pull && git stash pop";

      # Tmux
      tls = "tmux ls";
      tkill = "tmux kill-session -t ";

      # Docker
      dscript = "docker_script";

      # Gcloud
      gstart = "gcloud_start";
      gstop = "gcloud_stop";
      gzsh = "gcloud_enter";
      gcp = "gcloud_copy";
      gls = "gcloud compute instances list";

      # Jupyter
      kls = "jupyter kernelspec list";
      kstart = "start_kernel";
      knew = "create_kernel";
      krm = "delete_kernel";

      # Misc
      watch = "watch ";
      python = "python3";
      pip = "uv pip";
      bat = "bat --paging=never";
      re = "glow README.md";
      cpr = "rsync --recursive --progress";
      ipa = "ip -c a";
      fcd = "fuzzycd";
      cdl = "follow_link";
      pwf = "pwd_with_file";
      wlt = "watch tree -h --du ./";
      wlta = "watch tree -h --du -a ./";
      ".." = "cd ..";
    };

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
      set -g status-justify centre
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
    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      nil                          # Nix LSP
      pyright
      typescript-language-server
      clang-tools                  # clangd + clang-format
      vscode-langservers-extracted # jsonls, html, cssls, eslint
      bash-language-server

      # Formatters
      stylua
      ruff                         # Python formatter + linter
      black
      isort
      prettier
      shfmt
      codespell
      fixjson

      # Linters
      mypy
      shellcheck

      # Debuggers
      python3Packages.debugpy

      # Plugin dependencies
      imagemagick                  # for image.nvim
    ];
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/santos/dotnix/config/nvim";
  };

  # Powerlevel10k config (symlinked so `p10k configure` can edit in-place)
  home.file.".p10k.zsh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/santos/dotnix/config/p10k.zsh";

  # Docker shell functions
  home.file.".config/shell/docker_functions.bash".source =
    config.lib.file.mkOutOfStoreSymlink "/home/santos/dotnix/config/docker_functions.bash";

  # ============================================================================
  # GIT (basic config)
  # ============================================================================
  programs.git = {
    enable = true;
    settings.user.name = "Lucas Santos";
    # settings.user.email = "your@email.com";  # Uncomment and set
  };
}
