{
  flake.modules.nixos.actual = {
    services.actucal = {
      enable = true;
      openFirewall = true;
    };
  };
}
