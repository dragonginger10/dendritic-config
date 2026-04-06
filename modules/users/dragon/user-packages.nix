{
  flake.modules.homeManager.dragon-packages =
    { lib, pkgs, ... }:
    {
      # home.packages = with pkgs; [];
      programs = {
        bat.enable = true;
        lazygit.enable = true;
        btop.enable = true;
        fzf.enable = true;
        command-not-found.enable = true;

        ripgrep = {
          enable = true;
          arguments = [
            "--line-number"
            "--smart-case"
          ];
        };

        yazi = {
          enable = true;
          shellWrapperName = "y";
        };
      };
    };
}
