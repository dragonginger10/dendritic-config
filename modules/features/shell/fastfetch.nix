{ inputs, ... }:
{
  perSystem =
    let
      inherit (inputs.wrappers.lib) wrapPackage;
    in
    { pkgs, self', ... }:
    {
      packages.fastfetch = wrapPackage {
        inherit pkgs;
        package = pkgs.fastfetch;
        flags = {
          "-c" = "${self'.packages.fastfetch-eldritch}/config.jsonc";
        };
      };
    };
}
