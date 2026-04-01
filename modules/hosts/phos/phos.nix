{
  self,
  ...
}:
{
  nixosHosts.phos.enable = false;

  flake.modules.nixos."confs/phos" =
    { config, ... }:
    {
      nixpkgs.hostPlatform = "x86_64-linux";
      imports = with self.modules.nixos; [
        base
        dragon
        nix
      ];

      system.stateVersion = "25.11";
    };
}
