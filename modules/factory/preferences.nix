{
  flake.modules.generic.constants =
    { config, lib, ... }:
    {
      options.preferences = {
        user.name = lib.mkOption {
          type = lib.types.str;
          default = "dragon";
        };
      };
    };
}
