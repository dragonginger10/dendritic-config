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
          self.modules.generic.constants
          self.modules.nixos.secrets
        ];

        preferences.user.name = "${username}";
        users.mutableUsers = false;

        age.secrets.${username} = {
          file = "${self.inputs.secrets}/${username}.age";
          path = "/home/dragon/dragon.txt";
        };
        age.identityPaths = [
          "/home/dragon/.ssh/id_ed25519"
        ];

        users.users.${username} = {
          isNormalUser = true;
          password = "password";
          # hashedPasswordFile = "${config.age.secrets.${username}.path}";
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

        home-manager.users."${username}".imports = [
          self.modules.homeManager."${username}"
        ];
      };

  };
}
