{ self, ... }: {
  flake.modules.nixos."confs/cinnabar".imports = with self.modules.nixos; [
    grist
  ];
}
