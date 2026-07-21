{
  flake.modules.nixos = {
    # oci.virtualisation.oci-containers.backend = "docker";
    palworld = {
      networking.firewall = {
        allowedTCPPorts = [
          8211
        ];
        allowedUDPPorts = [
          27015
        ];
      };
      virtualisation.oci-containers.containers = {
        palworld = {
          image = "gameservermanagers/gameserver:pw";
          autoStart = true;
          ports = [
            "127.0.0.1:8211:8211"
            "127.0.0.1:8211:8211/udp"
            "127.0.0.1:27015:27015"
          ];
          volumes = [
            "palworld:/data"
          ];
        };
      };

    };
  };
}
