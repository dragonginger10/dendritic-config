{
  flake.modules.generic.constants =
    { config, lib, ... }:
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
}
