{
  flake.modules.nixos.caddy = { pkgs, ... }: {
    services.caddy = {
      enable = true;
      virtualHosts."dragonslibrary.xyz".extraConfig = ''
        encode gzip
        file_server
        root * ${
          pkgs.runCommand "testdir" { } ''
            mkdir "$out"
            echo hello world > "$out/index.html"
          ''
        }
      '';
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
