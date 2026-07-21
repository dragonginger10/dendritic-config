{ self, ... }: {
  nixosHosts.hoseki.enable = true;
  flake.modules.nixos."confs/hoseki" = { config, pkgs, ... }: {
    imports = with self.modules.nixos; [
      base
      nix
      cinnabar
      ssh
      agenix
      traefik
    ];

    age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJy5D93Si0kwEHZ8krIPAMK6hB/FrSbigtCLDWe4Fjm5 cinnabar@nixos";

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

    users.users.cinnabar = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMc+liCDZpVpeDt6cj5UJscoKxqmjKR4vMD6RNV+yAR dragon@wsl"
      ];
    };

    system.stateVersion = "26.05";
  };
}
