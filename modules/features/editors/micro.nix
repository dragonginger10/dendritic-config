{ self, inputs, ... }:
let
  inherit (inputs.wrappers.lib) wrapModule;
in
{
  perSystem =
    { pkgs, ... }:
    let
      micro = wrapModule (
        { pkgs, ... }:
        {
          config.package = pkgs.micro;
          config.env = {
            MICRO_CONFIG_HOME = "$HOME/.config/micro";
          };
        }
      );
    in
    {
      packages.micro = micro.wrap {
        inherit pkgs;
      };
    };
}
