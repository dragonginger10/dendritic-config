{
  flake.modules.nixos.caddy = {
    services.caddy = {
      enable = true;
      virtualHosts."localhost".extraConfig = ''
        respond "hello world"
      '';
    };
  };
}
