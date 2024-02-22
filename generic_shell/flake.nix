{
  description = "Genric dev shells that work for most projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells.rust = mkShell {
            buildInputs = [
                ( rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
                        targets = ["wasm32-unknown-unknown"];
                }) )
                rust-bin.stable.latest.default
                rust-analyzer
                mold
                cargo-nextest
                gnumake
                trunk
            ];
        };
        devShells.node = mkShell {
            buildInputs = [
                bun
                yarn
            ];
        };
        devShells.python = mkShell {
            buildInputs = [
                python311
                python311Packages.ipython
            ];
        };
    }
    );
}
