{ self, ... }:
{
  # Animated Wallpaper Engine backgrounds via linux-wallpaperengine.
  # Needs Wallpaper Engine (Steam app 431960) installed through Steam for its
  # assets; wallpapers are workshop items subscribed to in Steam.
  flake.modules = {
    nixos.wallpaperengine =
      { config, ... }:
      {
        assertions = [
          {
            assertion = config.programs.steam.enable;
            message = "wallpaperengine needs Steam for its assets; also import the `gaming` (or `steam`) feature.";
          }
        ];

        home-manager.users.${config.preferences.user.name} = {
          imports = [ self.modules.homeManager.wallpaperengine ];
          services.linux-wallpaperengine.assetsPath = "${config.preferences.steam.library}/steamapps/common/wallpaper_engine/assets";
        };
      };

    homeManager.wallpaperengine =
      { config, lib, ... }:
      let
        cfg = config.services.linux-wallpaperengine;
      in
      {
        services.linux-wallpaperengine = {
          # Stays off until at least one wallpaper is configured.
          enable = lib.mkDefault (cfg.wallpapers != [ ]);

          fps = 30;
          audio.silent = true;

          # monitor:   connector name from `niri msg outputs` (the part in parentheses)
          # wallpaper: workshop item id, i.e. a directory under
          #            <steam library>/steamapps/workshop/content/431960/
          wallpapers = [
            # {
            #   monitor = "HDMI-A-1";
            #   wallpaper = "1220909610";
            #   scaling = "fill";
            # }
          ];
        };
      };
  };
}
