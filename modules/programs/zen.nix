{
  flake-file.inputs.zen = {
    url = "github:youwen5/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { inputs', ... }:
    {
      packages.zen-browser = inputs'.zen.packages.default;
    };

}
