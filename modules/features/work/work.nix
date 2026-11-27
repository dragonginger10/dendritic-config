{ self, ... }:
{
  nixpkgs.allowedUnfreePackages = [ "slack" ];

  flake.modules = {
    nixos.work =
      { config, ... }:
      {
        home-manager.users.${config.preferences.user.name}.imports = [
          self.modules.homeManager.work
        ];
      };

    homeManager.work =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.slack ];
      };
  };
}
