{
  flake.modules.nixos."confs/cinnabar" = {
    # TODO: find extgra hw config from image
    fileSystem."/" = {
      device = "/dev/sda";
      fsType = "ext4";
    };

    swapDevices = [
      { device = "/dev/sdb"; }
    ];

    boot = {
      kernelParams = [ "console=ttyS0,19200n8" ];
      loader.grub = {
        enable = true;
        forceInstall = true;
        device = "nodev";
        timeout = 10;
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial
        '';
      };
    };
  };
}
