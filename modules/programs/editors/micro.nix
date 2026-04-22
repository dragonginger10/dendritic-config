{ self, inputs, ... }:
let
  inherit (inputs.wrappers.lib) wrapModule;
in
{
  flake.wrapModule.micro = wrapModule (
    { pkgs, ... }:
    {
      config.package = pkgs.micro;
      config.env = {
        MICRO_CONFIG_HOME = "$HOME/.config/micro";
      };
    }
  );

  perSystem =
    { pkgs, ... }:
    {
      packages.micro = self.wrapModule.micro.wrap {
        inherit pkgs;
      };
    };
}
