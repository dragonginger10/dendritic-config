{
  flake.modules.nixos.actual = {
    services.actual = {
      enable = true;
      openFirewall = true;
    };
  };
}
