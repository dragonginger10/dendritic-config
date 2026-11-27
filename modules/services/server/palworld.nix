{
  flake.modules.nixos = {
    # oci.virtualisation.oci-containers.backend = "docker";
    palworld = {
      networking.firewall.allowedUDPPorts = [
        8211
        27015
      ];
      virtualisation.oci-containers.containers = {
        palworld = {
          image = "gameservermanagers/gameserver:pw";
          autoStart = true;
          ports = [
            "8211:8211/udp"
            "27015:27015/udp"
          ];
          volumes = [
            "palworld:/data"
          ];
        };
      };

    };
  };
}
