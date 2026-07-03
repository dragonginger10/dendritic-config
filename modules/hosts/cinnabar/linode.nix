{ self, ... }: {
  perSystem = { config, pkgs, ... }: {
    terranix.terranixConfigurations.cinnabar = {
      modules = [ self.modules.terranixModules.cinnabar ];
      terraformWrapper.package = pkgs.opentofu;
      terraformWrapper.prefixText = ''
        TF_VAR_token="$(cat /run/agenix/linode)"
        export TF_VAR_token
      '';
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
      authorized_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos"
      ];
      root_pass = "WonderfullyInsecureLogin";
    };
  };
}
