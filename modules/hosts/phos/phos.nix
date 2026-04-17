{
  self,
  ...
}:
{
  nixosHosts.phos.enable = true;

  flake.modules.nixos."confs/phos" =
    { config, lib, ... }:
    {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      imports = with self.modules.nixos; [
        base
        nix
        boot
        gaming
        dragon
        displayManager
        desktop
      ];

      system.stateVersion = "25.11";

    };
}
