{ pkgs }:

with pkgs; let exe = haskell.lib.justStaticExecutables; in [
  (exe haskellPackages.cabal-install)
  (exe haskellPackages.hpack)
  aspell
  aspellDicts.en
  # cachix
  coreutils
  direnv
  fd
  # fzf
  # gawk
  # gnugrep
  # gnumake
  # gnuplot
  # gnutar
  # graphviz-nox
  # jq
  less
  # m-cli
  more
  # # my-scripts
  # nix-index
  # nix-info
  # nix-prefetch-scripts
  nix-scripts
  # nix-zsh-completions
  # nixpkgs-fmt
  # nixfmt
  # # openssh
  pandoc
  pstree
  # python27
  # python3
  ripgrep
  # ruby
  # sbcl
  # shfmt
  # sqlite
  tree
  # unixtools.ifconfig
  # unixtools.netstat
  # unixtools.ping
  # unixtools.route
  # unixtools.top
  # unrar
  # unzip
  # watch
  # watchman
  wget
  xz
  # yq
  # zip
]
