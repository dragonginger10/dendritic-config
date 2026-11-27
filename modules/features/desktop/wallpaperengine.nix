{ self, ... }:
{
  # Animated Wallpaper Engine backgrounds via linux-wallpaperengine.
  # Needs Wallpaper Engine (Steam app 431960) installed through Steam for its
  # assets; wallpapers are workshop items subscribed to in Steam.
  flake.modules = {
    nixos.wallpaperengine =
      { config, ... }:
      let
        steamapps = "${config.preferences.steam.library}/steamapps";
      in
      {
        assertions = [
          {
            assertion = config.programs.steam.enable;
            message = "wallpaperengine needs Steam for its assets; also import the `gaming` (or `steam`) feature.";
          }
        ];

        home-manager.users.${config.preferences.user.name} = {
          imports = [ self.modules.homeManager.wallpaperengine ];
          wallpaperengine.workshopDir = "${steamapps}/workshop/content/431960";
          services.linux-wallpaperengine.assetsPath = "${steamapps}/common/wallpaper_engine/assets";
        };
      };

    homeManager.wallpaperengine =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        cfg = config.services.linux-wallpaperengine;
        workshop = config.wallpaperengine.workshopDir;
      in
      {
        # Bare workshop ids are only resolved under the default ~/.steam library,
        # so wallpapers are given as full paths into this directory.
        options.wallpaperengine.workshopDir = lib.mkOption {
          type = lib.types.str;
          default = "${config.home.homeDirectory}/.local/share/Steam/steamapps/workshop/content/431960";
          description = "Wallpaper Engine workshop directory (one subdirectory per wallpaper id).";
        };

        config.services.linux-wallpaperengine = {
          # Stays off until at least one wallpaper is configured.
          enable = lib.mkDefault (cfg.wallpapers != [ ]);
          # Locally maintained copy (packages/linux-wallpaperengine.nix).
          package = pkgs.local.linux-wallpaperengine;

          fps = 30;
          audio.silent = true;
          # Background layer, so niri's place-within-backdrop rule applies (see below).
          extraOptions = [
            "--layer"
            "background"
          ];

          # monitor:   connector name from `niri msg outputs` (the part in parentheses)
          # wallpaper: "${workshop}/<workshop id>"
          wallpapers = [
            {
              monitor = "HDMI-A-1";
              wallpaper = "${workshop}/2370832694";
              scaling = "fill";
            }
          ];
        };

        # Default 100ms retries exhaust systemd's start limit (5 in 10s) within a second;
        # space them out so a slow login doesn't leave the wallpaper off.
        config.systemd.user.services.linux-wallpaperengine.Service.RestartSec = 2;
      };

    # Same treatment as noctalia's wallpaper: also show it behind the overview backdrop.
    # The backdrop sits behind each workspace's (opaque grey) background, so the
    # workspace background must be transparent for the wallpaper to show through.
    wrapper.niri.settings = {
      layer-rules = [
        {
          matches = [ { namespace = "^linux-wallpaperengine$"; } ];
          place-within-backdrop = true;
        }
      ];
      layout.background-color = "transparent";
    };
  };
}
