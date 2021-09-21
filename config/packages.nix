{ pkgs }:

with pkgs; let exe = haskell.lib.justStaticExecutables; in [
  (exe haskellPackages.cabal-install)
  (exe haskellPackages.hpack)
  (exe haskellPackages.haskell-language-server)
  (exe haskellPackages.hlint)
  (exe haskellPackages.hindent)
  (exe haskellPackages.ormolu)
  (exe haskellPackages.hie-bios)
  (exe haskellPackages.implicit-hie)
  ghc  
  aspell
  aspellDicts.en
  # cachix
  clang-tools  
  cppcheck
  coreutils
  emacsGit
  fd
  fzf
  gawk
  gdb
  gnugrep
  gnumake
  # gnuplot
  gnutar
  graphviz-nox
  jq
  less
  m-cli
  more
  nix-scripts
  nixpkgs-fmt
  nixfmt
  pandoc
  pstree
  python27
  python3
  ripgrep
  ruby
  rust-analyzer
  rustup
  shfmt
  sqlite
  tree
  # unixtools.ifconfig
  # unixtools.netstat
  # unixtools.ping
  # unixtools.route
  # unixtools.top
  unrar
  unzip
  # watch
  # watchman
  wget
  xz
  # yq
  zip
]
