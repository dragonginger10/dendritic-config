{ self, inputs, ... }:
{
  # Niri compositor. Its settings are spread across this directory; every file
  # contributes to `flake.modules.wrapper.niri`, which builds `pkgs.local.niri`.
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.xwayland-satellite ];

      programs.niri = {
        enable = true;
        package = pkgs.local.niri;
      };
    };

  flake.modules.wrapper.niri =
    { pkgs, lib, ... }:
    {
      options.preferences.niri.terminal = lib.mkOption {
        type = lib.types.package;
        default = pkgs.ghostty;
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.niri = inputs.wrappers.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.modules.wrapper.niri ];
      };
    };
}
