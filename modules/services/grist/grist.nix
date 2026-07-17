{
  flake.modules.nixos.grist = { config, ... }: {
    secrets.gristEnv = {
      rekeyFile = ./gristEnv.age;
    };
    services.traefik.dynamicConfigOptions.http = {
      services.grist.loadBalancer.servers = [
        { url = "http://localhost:8484"; }
      ];
      routers.grist = {
        entryPoints = [ "websecure" ];
        service = "grist";
        rule = "Host(`sheets.dragonslibrary.xyz`)";
        tls.certResolver = "letsencrypt";
      };
    };

    virtualisation.oci-containers.containers.grist = {
      image = "gristlabs/grist";
      ports = [ "8484:8484" ];
      volumes = [ "grist:/persist" ];
      environmentFiles = [
        config.secrets.gristEnv.path
      ];
    };
  };
}
