{ self, ... }:
{
  flake.factory.user = username: isAdmin: {
    nixos."${username}" =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        imports = [
          self.modules.nixos.ragenix
          self.modules.generic.constants
        ];
        preferences.user.name = "${username}";
        users.mutableUsers = false;
        users.users.${username} = {
          hashedPasswordFile = config.age.secrets.sneaky.path;
          isNormalUser = true;
          home = "/home/${username}";
          extraGroups = [
            "storage"
            "audio"
          ]
          ++ lib.optionals isAdmin [
            "wheel"
            "docker"
          ];
        };
      };

    home-manager.users."${username}" = {
      imports = [ self.modules.homeManager."${username}" ];
    };
  };
}
