{ self, ... }:
{
  flake.modules = {
    nixos.desktop =
      { pkgs, config, ... }:
      let
        selfpkgs = self.package.${pkgs.stdenv.hostPlatform.system};
      in
      {
        programs.niri.enable = true;
        programs.niri.package = selfpkgs.niri;

        environment.systemPackages = [ ];

        security.polkit.enable = true;
      };
  };
}
