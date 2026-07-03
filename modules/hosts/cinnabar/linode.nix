{
  PerSystem = { pkgs, ... }: {
    terranix.terranixConfiguration.cinnabar = {
      modules = [ ];
    };
  };

  flake.modules.terranixModules.cinnabar = { config, lib, ... }: {
    variable.token = {
      sensitive = true;
    };

    provider.linode = {
      token = "\${var.token}";
    };

    resource.linode_instance.simple = {
      label = "example";
      image = "linode/arch";
      region = "us-central";
      type = "g6-standard-1";
      authorized_keys = config.preferences.keys;
      root_pass = "totallyunsafe";
    };
  };
}
