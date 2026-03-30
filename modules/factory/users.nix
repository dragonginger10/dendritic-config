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
        imports = [ self.modules.nixos.ragenix ];
        users.mutableUsers = false;
        users.users.${username} = {
          hashedPasswordFile = config.age.secrets.sneaky.path;
          isNormalUser = true;
          home = "/home/${username}";
          extraGroups = lib.optionals isAdmin [
            "wheel"
            "storage"
            "audio"
            "docker"
          ];
        };
      };

    # home-manager.users."${username}" = {
    #   imports = [self.modules.homeManager."${username}"];
    # };
  };
}
