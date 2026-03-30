{ inputs, lib, ... }:
{
  flake-file.inputs.ragenix.url = lib.mkDefault "github:yaxitech/ragenix";

  flake.modules.nixos.ragenix =
    { pkgs, config, ... }:
    {
      imports = [ inputs.ragenix.nixosModules.default ];

      age.secrets.sneaky.file = ../../secrets/sneaky.age;
      age.identityPaths = [ "~/.ssh/id_ed25519" ];
    };
}
