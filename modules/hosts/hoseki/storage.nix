{ self, ... }:
{
  # Long-lived storage for hoseki, kept in its own terranix config (and its own state in
  # ./hoseki-storage) so destroying/recreating the VM config never touches the backups.
  #   nix run .#hoseki-storage                                  # init + apply
  #   (cd hoseki-storage && tofu output -raw restic_secret_key)  # read the key back
  # The bucket has prevent_destroy, so a destroy of this config is refused.
  perSystem =
    { pkgs, ... }:
    {
      terranix.terranixConfigurations.hoseki-storage = {
        modules = [ self.modules.terranixModules.hoseki-storage ];
        terraformWrapper.package = pkgs.opentofu;
        terraformWrapper.prefixText = ''
          TF_VAR_linodeapi="$(cat /run/agenix/linode)"
          export TF_VAR_linodeapi
        '';
      };
    };

  flake.modules.terranixModules.hoseki-storage = {
    variable.linodeapi.sensitive = true;

    provider.linode.token = "\${var.linodeapi}";

    resource = {
      linode_object_storage_bucket.backups = {
        # Bucket labels are globally unique per region; change it if apply says it's taken
        # (and update `bucket` in services/server/backup/backup.nix to match).
        label = "hoseki-backups";
        # Chicago: a different datacenter from the VM (us-central / Dallas).
        region = "us-ord";
        lifecycle.prevent_destroy = true;
      };

      # Access key that can only touch the backup bucket.
      linode_object_storage_key.restic = {
        label = "hoseki-restic";
        bucket_access = [
          {
            bucket_name = "\${linode_object_storage_bucket.backups.label}";
            region = "\${linode_object_storage_bucket.backups.region}";
            permissions = "read_write";
          }
        ];
      };
    };

    output = {
      restic_access_key = {
        value = "\${linode_object_storage_key.restic.access_key}";
        sensitive = true;
      };
      restic_secret_key = {
        value = "\${linode_object_storage_key.restic.secret_key}";
        sensitive = true;
      };
    };
  };
}
