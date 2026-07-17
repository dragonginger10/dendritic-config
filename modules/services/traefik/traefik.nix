{
  flake.modules.nixos.traefik = { config, ... }: {
    secrets."cfTraefik.env".rekeyFile = ./cfTraefik.age;

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    services.traefik = {
      enable = true;
      staticConfigOptions = {

        environmentFile = [
          config.secrets."cfTraefik.env".path
        ];

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
            http.tls.certResolver = "letsencrypt";
          };
        };

        log = {
          level = "INFO";
          filePath = "${config.services.traefik.dataDir}/traefik.log";
          format = "json";
        };

        certificatseResolvers.letsencrypt.acme = {
          email = "dragonginger10@gmail.com";
          storage = "${config.services.traefik.dataDir}/acme.json";
          dnschallenge = {
            provider = "cloudflare";
          };
        };

      };
    };
  };
}
