{ self, inputs, ... }:
{
  flake-file.inputs.pi-zero-2.url = "github:plmercereau/nixos-pi-zero-2";

  nixosHosts.bee.enable = true;

  flake.modules.nixos."confs/bee" =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = with self.modules.nixos; [
        nix
        base
        inputs.pi-zero-2.nixosModules.sd-image
        inputs.pi-zero-2.nixosModules.hardware
        bumblebee
      ];

      config = {
        nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

        boot = {
          initrd.availableKernelModules = [
            "xhci_pci"
            "usbhid"
            "usb_storage"
          ];
          loader.generic-extlinux-compatible.enable = true;
        };

        fileSystems = {
        "/" = {
            device = "/dev/disk/by-label/NIXOS_SD";
            options = [ "noatime" ];
            fsType = "ext4";
          };
        };

        networking = {
          wireless = {
            enable = true;
            networks."Cia ban".psk = "onerandompassword";
            interfaces = [ "wlan0" ];
          };
        };

        environment.systemPackages = with pkgs; [
          micro
        ];

        services = {
          openssh.enable = true;
        };

        hardware.enableRedistributableFirmware = true;
        system.stateVersion = "25.11";
      };
    };
}
