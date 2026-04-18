{ self, ... }:
{
  flake.modules = {
    nixos.desktop =
      { pkgs, config, ... }:
      let
        selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        environment.systemPackages = [
          selfpkgs.zen-browser
        ];

        programs.niri.enable = true;
        programs.niri.package = selfpkgs.niri;

        services.xserver = {
          enable = true;
          desktopManager.lxqt.enable = true;
        };
      };
  };
}
