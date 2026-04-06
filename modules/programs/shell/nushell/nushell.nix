{
  flake.modules.homeManager.nushell =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) getExe readFile;
    in
    {
      home = {
        sessionVariables.SHELLS = getExe pkgs.nushell;
        shell.enableNushellIntegration = true;

        shellAliases = {
          cp = "cp --recursive == verbose";
          mk = "mkdir";
          rm = "rm --recursive --verbose";
        };

        # packages = with pkgs; [];
      };

      programs = {
        carapace.enable = true;
        starship.enable = true;
        zoxide.enable = true;

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };

      programs.nushell = {
        enable = true;
        configFile.file = ./config.nu;
        plugins = with pkgs.nushellPlugins; [
          polars
        ];
      };
    };
}
