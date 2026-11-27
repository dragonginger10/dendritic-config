{
  # Nightly restic backups of server state to Linode Object Storage.
  # The bucket and its access key come from the `hoseki-storage` terranix config
  # (modules/hosts/hoseki/storage.nix). Paths follow whichever services are enabled.
  flake.modules.nixos.backup =
    { config, lib, ... }:
    let
      bucket = "hoseki-backups";
      endpoint = "us-ord-1.linodeobjects.com";
      inherit (config.services) paperless grist filebrowser;
    in
    {
      secrets = {
        # AWS_ACCESS_KEY_ID=<access key>
        # AWS_SECRET_ACCESS_KEY=<secret key>
        resticEnv.rekeyFile = ./resticEnv.age;
        # Repository encryption password. Keep a copy outside this server too:
        # without it the backups can't be decrypted.
        resticPass.rekeyFile = ./resticPass.age;
      };

      # Consistent paperless export (documents + manifest) at 01:30, before the backup.
      # Restore with `paperless-manage document_importer <dir>`.
      services.paperless.exporter.enable = lib.mkIf paperless.enable true;

      services.restic.backups.${config.networking.hostName} = {
        initialize = true;
        repository = "s3:https://${endpoint}/${bucket}/${config.networking.hostName}";
        environmentFile = config.secrets.resticEnv.path;
        passwordFile = config.secrets.resticPass.path;

        paths =
          lib.optional paperless.enable paperless.exporter.directory
          # DynamicUser: /var/lib/grist-core is only a symlink to this.
          ++ lib.optional grist.enable "/var/lib/private/grist-core"
          ++ lib.optional filebrowser.enable "/var/lib/filebrowser";

        # Grist keeps its data in sqlite files; stop it so the snapshot is consistent.
        backupPrepareCommand = lib.optionalString grist.enable "systemctl stop grist-core.service";
        backupCleanupCommand = lib.optionalString grist.enable "systemctl start grist-core.service";

        timerConfig = {
          OnCalendar = "03:00";
          Persistent = true;
          RandomizedDelaySec = "15m";
        };

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 4"
          "--keep-monthly 6"
        ];
        runCheck = true;
      };
    };
}
