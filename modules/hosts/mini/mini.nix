{ self, ... }:
{
  nixosHosts.mini.enable = false;
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
        vm
      ];

      config = {
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        system.stateVersion = "25.11";
        fileSystems = {
          "/".device = "/dev/vda1";
        };


        services.xserver = {
          enable = true;
          desktopManager.lxqt.enable = true;
          displayManager.lightdm.enable = true;
        };
      };
    };
}
