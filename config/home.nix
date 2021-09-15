{ config, pkgs, lib, ... }:

let home = builtins.getEnv "HOME";

in {
  home = {
    packages = pkgs.callPackage ./packages.nix { };

    sessionVariables = {
      ASPELL_CONF = "conf ${config.xdg.configHome}/aspell/config;";

    };

  };

  programs = {
    # Let Home Manager install and manage itself.
    # home-manager.enable = true;
    direnv.enable = true;
    bat.enable = true;
    broot.enable = true;
    gpg.enable = true;

    bash = {
      enable = true;
      bashrcExtra = lib.mkBefore ''
        source /etc/bashrc
      '';
    };

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

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };

      shellAliases = {
        ls = "${pkgs.coreutils}/bin/ls --color=auto";
        la = "${pkgs.coreutils}/bin/ls -a --color=auto";
        ll = "${pkgs.coreutils}/bin/ls -l -a --color=auto";

        # Use whichever cabal is on the PATH.
        cb = "cabal new-build";
        cn = "cabal new-configure --enable-tests --enable-benchmarks";
        cnp = "cabal new-configure --enable-tests --enable-benchmarks "
          + "--enable-profiling --ghc-options=-fprof-auto";

        # u/uu/uuu/...
        u = "cd ..";
        uu = "cd ../..";
        uuu = "cd ../../..";

        # Git 
        gb = "git branch";
        gtl = "git tag -l";
        ga = "git add";

        # emacsClient
        ec = ''emacsclient -t -a " "'';
        
        # Proxt Setting
        proxy = "export all_proxy=socks5://127.0.0.1:1080";
        unproxy = "unset all_proxy";
      };

      # defaultKeymap = "emacs";

      plugins = [
        {
          name = "iterm2_shell_integration";
          src = pkgs.fetchurl {
            url = "https://iterm2.com/shell_integration/zsh";
            sha256 = "1h38yggxfm8pyq3815mjd2rkb411v9g1sa0li884y0bjfaxgbnd4";
            # date = 2021-05-02T18:15:26-0700;
          };
        }
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
        NVIM_TUI_ENABLE_TRUE_COLOR = "1";

        HOME_MANAGER_CONFIG = /Users/aqua0210/src/nix/config/home.nix;

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
        DEV_ALLOW_ITERM2_INTEGRATION = "1";

        EDITOR = "vim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;

        GOPATH = "$HOME";

        # PATH = "$HOME/bin:$PATH";
      };
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
