{ self, ... }:
{
  flake.modules.nixos.vfio =
    { pkgs, config, ... }:
    {
      imports = [ self.modules.generic.constants ];

      boot = {
        kernelParams = [
          "amd_iommu=on"
          "kvm.ignore_msrs=1"
        ];
        kernelModules = [
          "vfio"
          "vfio_iommu_type1"
          "vfio_pci"
        ];
      };

      programs.virt-manager.enable = true;

      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull ];
          };
        };
      };

      users.users.${config.preferences.user.name}.extraGroups = [ "libvirtd" ];
    };
}
