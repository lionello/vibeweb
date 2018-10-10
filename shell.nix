#with import (builtins.fetchTarball "https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz") {};
with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    dmd dub rdmd
  ];
}

