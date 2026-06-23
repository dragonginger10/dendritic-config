{
  flake.modules.nixos.syncthing = { config, ... }: {
    services.syncthing = {
      enable = true;
      dataDir = "/home/${config.preferences.user.name}/Documents";
    };
  };
}
