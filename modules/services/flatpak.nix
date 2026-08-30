{
  flake.modules.nixos.flatpaks =
    { pkgs, ... }:
    let
      mountOptions = [
        "ro"
        "x-gvfs-hide"
        "resolve-symlinks"
      ];
    in
    {
      services.flatpak.enable = true;

      fonts.fontDir.enable = true;
      system.fsPackages = [ pkgs.bindfs ];

      fileSystems = {
        "/usr/share/fonts" = {
          device = "/run/current-system/sw/share/X11/fonts";
          fsType = "fuse.bindfs";
          options = mountOptions;
        };
        "/usr/share/icons" = {
          device = "/run/current-system/sw/share/icons";
          fsType = "fuse.bindfs";
          options = mountOptions;
        };
        "/usr/share/themes" = {
          device = "/run/current-system/sw/share/themes";
          fsType = "fuse.bindfs";
          options = mountOptions;
        };
      };

    };
}
