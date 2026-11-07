{
  flake.modules.nixos.wbtv = { config, ... }: {
    # services.traefik.dynamicConfigOptions.http = {
    #   services.grist.loadBalancer.servers = [
    #     { url = "http://localhost:8484"; }
    #   ];
    #   routers.grist = {
    #     entryPoints = [ "websecure" ];
    #     service = "tv";
    #     rule = "Host(`tv.dragonslibrary.xyz`)";
    #   };
    # };

    virtualisation.oci-containers.containers.wbtv = {
      image = "wb20244/wbtv:latest";
      ports = [ "8420:8080" ];
      volumes = [
        "/home/dragon/.config/wbtv:/config"
        "/TVvideos:/media:ro"
      ];
      environment = {
        TZ = "US/Central";
      };
      extraOptions = [
        "--tmpfs"
        "/tmp/wbtv:size=2g"
      ];
    };
  };
}
