{
  flake.modules.nixos.caddy = { pkgs, ... }: {
    services.caddy = {
      enable = true;
      virtualHosts = {
        "dragonslibrary.xyz".extraConfig = ''
          encode gzip 
          file_server
          root * ${
            pkgs.runCommand "testdir" { } ''
              mkdir "$out"
              echo hello world > "$out/index.html"
            ''
          }
        '';

        # "budget.dragonslibrary.xyz".extraConfig = ''
        #   encode gzip zstd
        #   reverse_proxy http://127.0.0.1:3000
        # '';

        "panel.dragonslibrary.xyz".extraConfig = ''
          reverse_proxy http://127.0.0.1:8080
        '';

      };
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
      allowedUDPPortRanges = [
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
  };
}
