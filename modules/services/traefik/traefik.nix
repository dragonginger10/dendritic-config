{
  flake.modules.nixos.traefik = { config, ... }: {
    secrets."cfTraefik.env" = {
      rekeyFile = ./cfTraefik.age;
      mode = "660";
      owner = "traefik";
      group = "traefik";
    };

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    services.traefik = {
      enable = true;

      environmentFiles = [
        "/run/agenix/cfTraefik.env"
      ];

      staticConfigOptions = {

        entryPoints = {
          web = {
            address = ":80";
            asDefault = true;
            http.redirections.entrypoint = {
              to = "websecure";
              scheme = "https";
            };
          };
          websecure = {
            address = ":443";
            asDefault = true;
            http.tls.certResolver = "le";
          };
        };

        log = {
          level = "INFO";
          filePath = "${config.services.traefik.dataDir}/traefik.log";
          format = "json";
        };

        certificatesResolvers.le.acme = {
          email = "dragonginger10@gmail.com";
          storage = "${config.services.traefik.dataDir}/acme.json";
          dnsChallenge.provider = "cloudflare";
        };

      };

      dynamicConfigOptions.http = {
        routers.wildcard = {
          rule = "Host(`*.dragonslibrary.xyz`)";
          tls.certResolver = "le";
        };
      };
    };
  };
}
