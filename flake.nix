{
  description = "A wrapper flake for lojix";

  inputs = {
    flakeWorld = { type = "indirect"; id = "flakeWorld"; };

    clj-nix = {
      type = "indirect";
      id = "clj-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    src = {
      url = "github:sajban/lojix";
      false = false;
    };
  };

  outputs = inputs@{ self, flakeWorld, ... }:
    flakeWorld.make.simpleWrapperFlake inputs;
}
