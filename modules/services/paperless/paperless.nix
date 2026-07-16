{
  flake.modules.nixos.paperless = { config, ... }: {
    secrets.paperpass = {
      rekeyFile = ./paperpass.age;
    };
    services.paperless = {
      enable = true;
      domain = "docs.dragonslibrary.xyz";
      port = 28981;
      passwordFile = config.secrets.paperpass.path;
    };
  };
}
