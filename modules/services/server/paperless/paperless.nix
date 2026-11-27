{
  flake.modules.nixos.paperless = { config, ... }: {
    secrets.paperpass = {
      rekeyFile = ./paperpass.age;
    };

    services = {
      traefik.dynamicConfigOptions.http = {
        services.paperless.loadBalancer.servers = [
          { url = "http://localhost:${toString config.services.paperless.port}"; }
        ];
        routers.paperless = {
          entryPoints = [ "websecure" ];
          service = "paperless";
          rule = "Host(`docs.dragonslibrary.xyz`)";
          tls.certResolver = "le";
        };
      };

      paperless = {
        enable = true;
        domain = "docs.dragonslibrary.xyz";
        port = 28981;
        passwordFile = config.secrets.paperpass.path;
      };
    };
  };
}
