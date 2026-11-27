{
  flake.modules.nixos.file = { config, ... }: {
    services = {
      filebrowser.enable = true;

      traefik.dynamicConfigOptions.http = {
        services.files.loadBalancer.servers = [
          { url = "http://localhost:${toString config.services.filebrowser.settings.port}"; }
        ];
        routers.files = {
          service = "files";
          rule = "Host(`files.dragonslibrary.xyz`)";
          tls.certResolver = "le";
        };
      };

    };
  };
}
