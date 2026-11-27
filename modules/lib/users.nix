{ self, lib, ... }:
{
  # Returns flake.modules for a user account. If the user also defines
  # flake.modules.homeManager.<username>, home-manager is imported and wired up.
  flake.lib.user =
    username: isAdmin:
    let
      hasHome = self.modules.homeManager ? ${username};
    in
    {
      nixos."${username}" =
        { lib, ... }:
        {
          imports = [
            self.modules.generic.constants
          ]
          ++ lib.optional hasHome self.modules.nixos.home-manager;

          preferences.user.name = "${username}";
          # users.mutableUsers = false;

          users.users.${username} = {
            isNormalUser = true;
            initialPassword = "password";
            home = "/home/${username}";
            extraGroups = [
              "storage"
              "audio"
            ]
            ++ lib.optionals isAdmin [
              "wheel"
            ];
          };
        }
        // lib.optionalAttrs hasHome {
          home-manager.users.${username}.imports = [ self.modules.homeManager.${username} ];
        };
    };
}
