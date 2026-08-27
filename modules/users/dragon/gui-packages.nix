{
  nixpkgs.allowedUnfreePackages = [
    "discord"
  ];

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mattermost-desktop
        mupdf
        feh
        nautilus
        discover-overlay
        mpv
        calibre
        noctalia-shell
        freenet
      ];

      programs = {
        discord.enable = true;
        spotify-player.enable = true;
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
