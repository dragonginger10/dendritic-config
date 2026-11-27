{ self, ... }:
{
  # Compositor-agnostic graphical desktop. Pair with a WM/DE feature (e.g. niri).
  flake.modules.nixos.desktop =
    { config, pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        stylix
        fonts
        flatpaks
        sound
      ];

      home-manager.users.${config.preferences.user.name}.imports = [
        self.modules.homeManager.gui
      ];

      environment.systemPackages = with pkgs.local; [
        zen-browser
        antra
        grist-desktop
      ];

      services.udev.packages = [ pkgs.vial ];
    };
}
