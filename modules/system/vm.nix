{
  flake.modules.nixos.vm = {
      virtualisation.vmVariant = {
        useDefaultFilesystems = false;
        virtualisation = {
          memorySize = 4096;
          cores = 4;
        };
      };
  };
}
