{ self, ... }: {
  flake.modules.nixos."confs/hoseki".imports = with self.modules.nixos; [
    file
  ];
}
