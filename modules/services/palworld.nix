{
  flake.modules.nixos = {
    # oci.virtualisation.oci-containers.backend = "docker";
    palworld.virtualisation.oci-containers.containers = {
      palworld = {
        image = "gameservermanagers/gameserver:pw";
        autoStart = true;
        ports = [
          "127.0.0.1:8211:8211"
          "127.0.0.1:8211:8211/udp"
        ];
        volumes = [
          "palworld:/data"
        ];
      };
    };

  };
}
