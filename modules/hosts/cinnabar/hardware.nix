{
  flake.modules.nixos."confs/cinnabar" = { lib, modulesPath, ... }: {
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    fileSystem."/" = {
      device = "/dev/sda";
      fsType = "ext4";
    };

    swapDevices = [
      { device = "/dev/sdb"; }
    ];

    boot = {
      kernelParams = [ "console=ttyS0,19200n8" ];
      kernelModules = [ ];
      extraModulePackages = [ ];
      initrd = {
        availableKernelModules = [
          "virtio_pci"
          "virtio_scsi"
          "ahci"
          "sd_mod"
        ];
        kernelModules = [ ];
      };
      loader = {
        timeout = 10;
        grub = {
          enable = true;
          forceInstall = true;
          device = "nodev";
          extraConfig = ''
            serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
            terminal_input serial;
            terminal_output serial
          '';
        };
      };
    };
  };
}
