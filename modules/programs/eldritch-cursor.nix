{ self, ... }:
{
  flake-file.inputs.eldritch-cursors = {
    url = "github:eldritch-theme/cursors";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.eldritch-cursors =
    { pkgs, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = [ selfpkgs.eldritch-cursors ];

      stylix.cursor = {
        name = "eldritch-great-old-green-cursors";
        package = selfpkgs.eldritch-cursors;
        size = 32;
      };
    };

  perSystem =
    { inputs', ... }:
    {
      packages.eldritch-cursors = inputs'.eldritch-cursors.packages.great-old-green;
    };
}
