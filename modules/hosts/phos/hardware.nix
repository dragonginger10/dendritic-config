{
  flake.modules.nixos."confs/phos" =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/ROOT";
          fsType = "ext4";
        };

        "/boot/efi" = {
          device = "/dev/disk/by-uuid/1DB1-8403";
          fsType = "vfat";
        };

        "/home" = {
          device = "/dev/disk/by-label/HOME";
          fsType = "ext4";
        };

        "/games" = {
          device = "/dev/disk/by-label/GAMES";
          fsType = "ext4";
        };
      };

      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];
        initrd.kernelModules = [ ];
        kernelParams = [ "amd_iommu=on" ];
        plymouth = {
          enable = true;
          themePackages = [
            pkgs.local.dracula-plymouth
          ];
          theme = lib.mkForce "dracula";
        };
        loader.grub = {
          gfxmodeEfi = "3440x1440";
          extraEntries = ''
            menuentry "Batocera" {
                search --set=root --label BATOCERA
                linux /boot/linux label=BATOCERA console=tty3 quiet loglevel=0 vt.global_cursor_default=0
                initrd /boot/initrd.gz
            }
          '';
        };
        blacklistedKernelModules = [ "hid-thrustmaster" ];

        extraModulePackages = with config.boot.kernelPackages; [
          hid-tmff2
        ];
        kernelModules = [
          "hid-tmff2"
          "kvm-amd"
        ];
      };

      swapDevices = [ ];
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

      hardware = {
        cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        keyboard.qmk.enable = true;
        bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings.General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
      # high-resolution display
    };
}
