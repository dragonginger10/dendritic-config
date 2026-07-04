{ self, ... }: {
  perSystem = { pkgs, ... }: {
    terranix.terranixConfigurations.cinnabar = {
      modules = [ self.modules.terranixModules.cinnabar ];
      terraformWrapper.package = pkgs.opentofu;
      terraformWrapper.prefixText = ''
        TF_VAR_linodeapi="$(cat /run/agenix/linode)"
        CLOUDFLARE_API_TOKEN="$(cat /run/agenix/cloudapi)"
        export TF_VAR_linodeapi
        export CLOUDFLARE_API_TOKEN
      '';
    };
  };

  flake.modules.terranixModules.cinnabar = rec {
    variable = {
      linodeapi.sensitive = true;
      zone_id.default = "5f2767cb21a39e2115e3f02ca3d2ad9a";
      account_id.default = "c48cd0a6425c220b98338b276e7d21e3";
      domain.default = "dragonslibrary.xyz";
    };

    provider = {
      linode = {
        token = "\${var.linodeapi}";
      };
      cloudflare = { };
    };

    resource = {
      linode_instance.vps = {
        label = "cinnabar";
        region = "us-central";
        type = "g6-standard-2";
      };

      linode_instance_disk = {
        nixos = {
          linode_id = "\${linode_instance.vps.id}";
          label = "nixos";
          size = "\${linode_instance.vps.specs.0.disk - 1024}";
          image = "private/39801950";
          root_pass = "tottally useless password";
        };
        swap = {
          linode_id = "\${linode_instance.vps.id}";
          label = "swap";
          size = 1024;
          filesystem = "swap";
        };
      };

      linode_instance_config.bootable = {
        linode_id = "\${linode_instance.vps.id}";
        label = "bootable";
        booted = true;
        kernel = "linode/grub2";
        device = [
          {
            device_name = "sda";
            disk_id = "\${linode_instance_disk.nixos.id}";
          }
          {
            device_name = "sdb";
            disk_id = "\${linode_instance_disk.swap.id}";
          }
        ];

      };

      cloudflare_dns_record.base = {
        name = "dragonslibrary.xyz";
        zone_id = variable.zone_id.default;
        content = "\${tolist(linode_instance.vps.ipv4)[0]}";
        type = "A";
        ttl = 60;
        proxied = false;
        comment = "Domain verification";
      };
    };

  };
}
