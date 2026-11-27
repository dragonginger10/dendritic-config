{
  flake-file.inputs.eldritch-cursors = {
    url = "github:eldritch-theme/cursors";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.eldritch-cursors =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.local.eldritch-cursors ];

      stylix.cursor = {
        name = "eldritch-great-old-green-cursors";
        package = pkgs.local.eldritch-cursors;
        size = 32;
      };
    };

  perSystem =
    { inputs', ... }:
    {
      packages.eldritch-cursors = inputs'.eldritch-cursors.packages.great-old-green;
    };
}
