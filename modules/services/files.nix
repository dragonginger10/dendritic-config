{
  flake.modules.nixos.file = {
    services = {

      traefik.dynamicConfigOptions.http = {
        services.files.loadBalancer.servers = [
          { url = "http://localhost:8080"; }
        ];
        routers.files = {
          entryPoints = [ "websecure" ];
          service = "files";
          rule = "Host(`files.dragonslibrary.xyz`)";
          tls.certResolver = "le";
        };
      };

      filebrowser.enable = true;
    };
  };
}
