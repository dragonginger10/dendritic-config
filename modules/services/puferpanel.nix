{
  flake.modules.nixos.pufferpanel =
    { pkgs, lib, ... }:
    let
      pufferpanel-fhs = pkgs.buildFHSEnv {
        name = "pufferpanel-fhs";
        runscript = lib.getExe pkgs.pufferpanel;
      };
    in
    {
      environment.systemPackages = [ pkgs.pufferpanel ];
      services.pufferpanel = {
        enable = true;
        extraGroups = [ "docker" ];
        # extraPackages = with pkgs; [];
        environment = {
          PUFFER_PANEL_ENABLE = "true";
          PUFFER_CONFIG = "/home/kongo/puff";
          PUFFER_PANEL_CONSOLE_FORWARD = "true";
          PUFFER_PANEL_DATABASE_DIALECT = "sqlite3";
          PUFFER_PANEL_DATABASE_URL = "file:/home/kongo/puff/pufferpanel.db";
          PUFFER_PANEL_REGISTRATIONENABLED = "false";
        };
      };
    };
}
