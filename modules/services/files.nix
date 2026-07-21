{
  flake.modules.nixos.file = {
    services = {

      traefik.dynamicConfigOptions.http = {
        services.grist.loadBalancer.servers = [
          { url = "http://localhost:8080"; }
        ];
        routers.grist = {
          entryPoints = [ "websecure" ];
          service = "files";
          rule = "Host(`files.dragonslibrary.xyz`)";
          tls.certResolver = "letsencrypt";
        };
      };

      filebrowser.enable = true;
    };
  };
}
