{
  flake.modules.nixos.traefik = { config, ... }: {
    # Exactly one line, no `export`/quotes:
    # CLOUDFLARE_DNS_API_TOKEN=<Cloudflare token with Zone:DNS:Edit on dragonslibrary.xyz>
    secrets."cfTraefik.env" = {
      rekeyFile = ./cfTraefik.age;
      mode = "0400";
      owner = "traefik";
      group = "traefik";
    };

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    services.traefik = {
      enable = true;
      environmentFiles = [ config.secrets."cfTraefik.env".path ];

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
            # One wildcard cert shared by every router; routers need no tls settings.
            http.tls = {
              certResolver = "le";
              domains = [
                {
                  main = "dragonslibrary.xyz";
                  sans = [ "*.dragonslibrary.xyz" ];
                }
              ];
            };
          };
        };

        # No filePath: logs go to the journal (`journalctl -u traefik`).
        log = {
          level = "INFO";
          format = "json";
        };

        certificatesResolvers.le.acme = {
          email = "dragonginger10@gmail.com";
          storage = "${config.services.traefik.dataDir}/acme.json";
          dnsChallenge = {
            provider = "cloudflare";
            resolvers = [
              "1.1.1.1:53"
              "9.9.9.9:53"
            ];
            propagation.delayBeforeChecks = "10s";
          };
        };
      };
    };
  };
}
