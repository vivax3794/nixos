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
                ( rust-bin.selectLatestNWith (toolchain: toolchain.default.override {
                    extensions = ["rust-analyzer"];
                }) )
                rust-bin.stable.latest.default
                cargo-nextest
            ];
        };
        devShells.node = mkShell {
            buildInputs = [
                nodejs_20
            ];
        };
    }
    );
}
