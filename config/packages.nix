{ pkgs }:

with pkgs; let exe = haskell.lib.justStaticExecutables; in
[
  # Haskell tools
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
  clang-tools
  cppcheck
  coq
  coreutils
  emacsGit
  fd
  gawk
  gdb
  gnugrep
  gnumake
  gnuplot
  gnutar
  graphviz-nox
  hugo
  j
  jq
  less
  m-cli
  more
  mpv
  nix-scripts
  nixpkgs-fmt
  nixfmt
  nodejs
  nodePackages.eslint
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
  unrar
  unzip
  wget
  xz
  zip
]
