{ self, ... }:
{
  flake.modules = {
    nixos.media =
      { config, ... }:
      {
        home-manager.users.${config.preferences.user.name}.imports = [
          self.modules.homeManager.media
        ];
      };

    homeManager.media =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          ani-cli
          nyaa
          openhue-cli
          qbittorrent
          twitch-tui
          wtwitch
        ];

        programs.yt-dlp.enable = true;
      };
  };
}
