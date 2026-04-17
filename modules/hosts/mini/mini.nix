{ self, ... }:
{
  nixosHosts.mini.enable = true;
  flake.modules.nixos."confs/mini" =
    {
      config,
      lib,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        nix
        boot
        base
        dragon
      ];

      config = {
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        system.stateVersion = "25.11";
        fileSystems = {
          "/".device = "/dev/vda1";
        };

        virtualisation.vmVariant = {
          useDefaultFilesystems = false;
          virtualisation = {
            memorySize = 4096;
            cores = 4;
          };
        };

        services.xserver = {
          enable = true;
          desktopManager.lxqt.enable = true;
          displayManager.lightdm.enable = true;
        };
      };
    };
}
