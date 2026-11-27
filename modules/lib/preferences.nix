let
  preferences =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {
      options.preferences = {
        user.name = mkOption {
          type = types.str;
          default = "dragon";
        };

        theme = mkOption {
          type = types.str;
          default = "eldritch";
        };

        keys = mkOption {
          type = with types; listOf str;
        };

        autostart = mkOption {
          type = types.listOf (types.either types.str types.package);
          default = [ ];
        };
      };
    };
in
{
  # `key` makes the module system dedupe this, so any module may import it.
  flake.modules.generic.constants.imports = [
    {
      key = "dendritic#generic.constants";
      imports = [ preferences ];
    }
  ];
}
