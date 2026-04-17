{
  flake-file.inputs.zen = {
    url = "github:youwen5/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem = {pkgs, inputs', ...}: {
    package = {
      zen-browser = inputs'.zen.packages.default;
    };
  };
}
