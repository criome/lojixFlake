{
  description = "A wrapper flake for lojix";
  inputs = {
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
            lockfile = self + "/deps-lock.json"; # Upstream bug: should support a path
            nativeImage.enable = false;
          }];
        };

      };
    });
}
