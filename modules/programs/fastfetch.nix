{ inputs, ... }:
{
  perSystem =
    let
      inherit (inputs.wrappers.lib) wrapPackage;
    in
    { pkgs, ... }:
    {
      packages.fastfetch = wrapPackage {
        inherit pkgs;
        package = pkgs.fastfetch;
        flags = {
          "-c" = "${pkgs.local.fastfetch-eldritch}/config.jsonc";
        };
      };
    };
}
