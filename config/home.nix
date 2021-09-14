{ config, pkgs, lib, ... }:

let
  home = builtins.getEnv "HOME";
  callPackage = pkgs.callPackage;

in {
  home = {
    packages = callPackage ./packages.nix { };

    sessionVariables = {
      ASPELL_CONF = "conf ${config.xdg.configHome}/aspell/config;";

    };

  };

  # home.file.".gnupg/gpg-agent.conf".text = ''
  # '' + (if pkgs.stdenv.isDarwin then ''
  #   pinentry-program = ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  # '' else
  #   "");

  # home.file.".config/karabiner/karabiner.json".source = ./home/karabiner.json;

  # home.file.".iterm2_shell_integration.zsh".source =
  #   ./home/.iterm2_shell_integration.zsh;

  # home.file.".config/nvim/backup/.keep".text = "";

  # home.file.".hammerspoon".source = /b/etc/hammerspoon;

  programs = {
    # Let Home Manager install and manage itself.
    # home-manager.enable = true;
    direnv.enable = true;
    bat.enable = true;
    broot.enable = true;
    gpg.enable = true;

    git = {
      enable = true;
      userName = "Eason Huang";
      userEmail = "aqua0210@163.com";
      extraConfig = {
        hub.protocol = "https";
        github.user = "Eason0210";
        color.ui = true;
        pull.rebase = true;
        merge.conflictstyle = "diff3";
        credential.helper = "osxkeychain";
        diff.algorithm = "patience";
        protocol.version = "2";
        core.commitGraph = true;
        gc.writeCommitGraph = true;
      };
    };

    ssh = {
      enable = true;
      # extraConfig = ''
      #   Include ~/.spin/ssh/include
      # '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        path = ".local/share/zsh/.zsh_history";
        size = 50000;
        save = 50000;
      };
      shellAliases = import ./home/aliases.nix;
      defaultKeymap = "emacs";
      # initExtraBeforeCompInit = ''
      #   eval $(${pkgs.coreutils}/bin/dircolors -b ${./home/LS_COLORS})
      #   ${builtins.readFile ./home/pre-compinit.zsh}
      # '';
      # initExtra = builtins.readFile ./home/post-compinit.zsh;

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.6.3";
            sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
            sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
          };
        }
      ];

      sessionVariables = rec {
        # NVIM_TUI_ENABLE_TRUE_COLOR = "1";

        HOME_MANAGER_CONFIG = /Users/aqua0210/src/nix/config/home.nix;

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
        DEV_ALLOW_ITERM2_INTEGRATION = "1";

        EDITOR = "vim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;

        GOPATH = "$HOME";

        # PATH = "$HOME/bin:$PATH";
      };
      # envExtra
      # profileExtra
      # loginExtra
      # logoutExtra
      # localVariables
    };

    neovim = {
      enable = true;
      vimAlias = true;
      # extraConfig = builtins.readFile ./home/extraConfig.vim;

      plugins = with pkgs.vimPlugins; [
        # Syntax / Language Support ##########################
        vim-nix
        # UI #################################################
        gruvbox # colorscheme
        vim-gitgutter # status in gutter
        # vim-devicons
        vim-airline
      ];
    };
  };

  xdg = {
    enable = true;

    configFile."aspell/config".text = ''
      local-data-dir ${pkgs.aspell}/lib/aspell
      data-dir ${pkgs.aspellDicts.en}/lib/aspell
      personal ${config.xdg.configHome}/aspell/en_US.personal
      repl ${config.xdg.configHome}/aspell/en_US.repl
    '';
  };

}
