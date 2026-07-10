{
  flake.modules.nixos.grist = { config, ... }: {
    secrets.gristEnv = {
      rekeyFile = ./gristEnv.age;
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
