{ self, ... }:
{
  flake.modules = {
    nixos.desktop =
      { pkgs, config, ... }:
      let
        selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        environment.systemPackages = with pkgs; [
          selfpkgs.zen-browser
          gpu-screen-recorder-gtk
        ];

        programs = {
          gpu-screen-recorder.enable = true;

          niri = {
            enable = true;
            package = selfpkgs.niri;
          };

        };

        services = {
          flatpak.enable = true;
          xserver = {
            enable = true;
            desktopManager.lxqt.enable = true;
          };

          udev.packages = [
            pkgs.via
          ];
        };
      };
  };
}
