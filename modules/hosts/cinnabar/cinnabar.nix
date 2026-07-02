{ self, ... }: {
  nixosHosts.cinnabar.enable = true;
  flake.modules.nixos."confs/cinnabar" = { pkgs, ... }: {
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

    users.users.kongo = {
      openssh.authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos"
      ];
    };

    system.stateVersion = "26.05";
  };
}
