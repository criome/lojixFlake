{
  description = "A wrapper flake for lojix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    clj-nix.url = "github:jlesquembre/clj-nix";
    lojix = {
      url = "github:sajban/lojix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, clj-nix, lojix }:

    flake-utils.lib.eachDefaultSystem (system: {

      packages = {

        default = clj-nix.lib.mkCljApp {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [{
            projectSrc = lojix;
            name = "sajban/lojix";
            main-ns = "lojix.main";
            version = "bootstrap";
            nativeImage.enable = false;
          }];
        };

      };
    });
}
