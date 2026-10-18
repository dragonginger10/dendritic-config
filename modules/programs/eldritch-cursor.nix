{
  flake-file.inputs.eldritch-cursors = {
    url = "github:eldritch-theme/cursorss";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.eldritch-cursors =
    { self', ... }:
    {
      environment.systemPkgs = [ self'.packages.eldritch-cursors ];

      stylix.cursor = {
        name = "Eldritch Cthulhu Great Old One Green";
        package = self'.packages.eldritch-cursors.great-old-green;
        size = 32;
      };
    };

  perSystem =
    { inputs', ... }:
    {
      packages.eldritch-cursors = inputs'.eldritch-cursors.packages.default;
    };
}
