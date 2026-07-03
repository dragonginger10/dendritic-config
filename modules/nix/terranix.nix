{ inputs, ... }: {
  flake-file.inputs.terranix = {
    url = "github:terranix/terranix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [ inputs.terranix.flakeModule ];
}
