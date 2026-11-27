{
  flake.modules.wrapper.niri =
    { lib, pkgs, ... }:
    {
      menus."Mod+d".m = {
        desc = "mattermost";
        cmd = lib.getExe pkgs.mattermost-desktop;
      };
    };

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mattermost-desktop
        mupdf
        feh
        nautilus
        mpv
        spotatui
        calibre
      ];

      programs = {
        ghostty = {
          enable = true;
          settings = {
            background-opacity = 0.85;
            font-size = 12;
          };
        };
      };
    };
}
