{
  flake.modules.nixos.pufferpanel = { pkgs, lib, ... }: {
    services.pufferpanel = {
      enable = true;
      package = pkgs.buildFHSEnv {
        name = "pufferpanel-fhs";
        runscript = lib.getExe pkgs.pufferpanel;
        targetPkgs =
          pkgs': with pkgs'; [
            icu
            openssl
            zlib
          ];
      };
      environment = {
        PUFFER_WEB_HOST = ":8080";
        PUFFER_DAEMON_SFTP_HOST = ":5657";
        PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
        PUFFER_DAEMON_CONSOLE_FORWARD = "true";
        PUFFER_PANEL_REGISTRATIONENABLED = "false";
      };
    };
  };
}
