{ self, ... }:
{
  flake.modules.nixos.base =
    { config, lib, ... }:
    {
      imports = [ self.modules.nixos.ragenix ];

      options.preferences = {
        user.name = lib.mkOption {
          type = lib.types.str;
          default = "dragon";
        };
      };

      config = {
        users.mutableUsers = false;
        users.users.${config.preferences.user.name} = {
          hashedPasswordFile = config.age.secrets.sneaky.path;
          isNormalUser = true;
          description = "JP (${config.preferences.user.name})";
          extraGroups = [
            "wheel"
            "storage"
            "audio"
            "docker"
          ];
        };
      };
    };
}
