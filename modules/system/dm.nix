{
  flake.modules.nixos.displayManager = {
    services.displayManager = {
      enable = true;
      ly.enable = true;
    };
  };
}
