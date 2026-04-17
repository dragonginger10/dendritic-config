{ self, ... }:
{
  flake.module =
    { pkgs, config, ... }:
    let
      selfpkgs = self.package.${pkgs.stdenv.hostPlatform.system};
      username = config.prefernces.user.name;
    in
    {
      nixos.desktop = {
        # imports = [];

        programs.niri.enable = true;
        programs.niri.package = selfpkgs.niri;

        # prefernces.autostart = [];

        environment.systemPackages = [ ];

        security.polkit.enable = true;
      };

      homeManager.${username} = {
        imports = with self.modules.homeManager; [
          gui
        ];
      };
    };
}
