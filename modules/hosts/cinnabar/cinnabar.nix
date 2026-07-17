{ self, ... }: {
  nixosHosts.cinnabar.enable = true;
  flake.modules.nixos."confs/cinnabar" = { config, pkgs, ... }: {
    imports = with self.modules.nixos; [
      base
      nix
      kongo
      vm
      ssh
      docker
      traefik
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
      lazydocker
    ];

    users.users.kongo = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos"
      ];
    };

    system.stateVersion = "26.05";
  };
}
