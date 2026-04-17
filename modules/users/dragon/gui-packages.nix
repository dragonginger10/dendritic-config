{
  flake.modules.homeManager.gui = {
    programs = {
      discord.enable = true;
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
