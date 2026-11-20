{
  flake-file.inputs.zen = {
    url = "github:youwen5/zen-browser-flake?rev=458cd16116c362a5e92d5db6bdc3599e4e8b1f4a";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { inputs', ... }:
    {
      packages.zen-browser = inputs'.zen.packages.default;
    };

}
