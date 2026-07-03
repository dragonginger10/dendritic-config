{ self, ... }: {
  nixosHosts.cinnabar.enable = true;
  flake.modules.nixos."confs/cinnabar" = { config, pkgs, ... }: {
    imports = with self.modules.nixos; [
      base
      nix
      kongo
      vm
    ];

    networking = {
      useDHCP = false;
      usePredictableInterfaceNames = false;
      interfaces.eth0.useDHCP = true;
    };

    environment.systemPackages = with pkgs; [
      mtr
      sysstat
      inetutils
    ];

    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    users.users.kongo = {
      openssh.authorizedKeys.keys = config.preferences.keys;
    };

    system.stateVersion = "26.05";
  };
}
