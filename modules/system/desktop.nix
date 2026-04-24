{ self, ... }:
{
  flake.modules = {
    nixos.desktop =
      { config, pkgs, ... }:
      let
        selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
        username = config.preferences.user.name;
      in
      {
        imports = with self.modules.nixos; [
          stylix
          fonts
        ]
        home-manager.users.${username}.imports = with self.modules.homeManager; [
          gui
        ];

        environment.systemPackages = with pkgs; [
          selfpkgs.zen-browser
          gpu-screen-recorder-gtk
          noctalia-shell
          xwayland-satellite
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
          udev.packages = [
            pkgs.vial
          ];
        };
      };
  };
}
