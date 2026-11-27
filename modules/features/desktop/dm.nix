{
  flake.modules.nixos.displayManager = {
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          auth_fails = 3;
          shell = false;
        };
      };
    };
  };
}
