{ self, ... }: {
  nixosHosts.cinnabar.enable = false;
  flake.modules.nixos."confs/cinnabar" = { pkgs, ... }: {
    # TODO: Get config from image
    imports = with self.modules.nixos; [
      kongo
    ];
    networking = {
      useDHCP = false;
      usePredicatbleInterfaceNames = false;
      interfaces.eth0.useDHCP = true;
    };

    environment.systemPackages = with pkgs; [
      mtr
      sysstat
      inetutils
    ];

    services.openssh = {
      enable = true;
      settings.permitRootLogin = "no";
    };

    system.stateVersion = "26.05";
  };
}
