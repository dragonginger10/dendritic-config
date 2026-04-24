{ self, ... }:
{
  nixosHosts.bee.enable = true;
  flake.modules.nixos."confs/bee" =
    {
      config,
      lib,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        nix
        base
      ];

      config = {
        nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
        system.stateVersion = "25.11";
        fileSystems = {
          "/".device = "/dev/disk/by-label/NIXOS_SD";
        };

      };
    };
}
