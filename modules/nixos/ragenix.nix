{ inputs, lib, ... }:
{
  flake-file.inputs = {
    ragenix.url = lib.mkDefault "github:yaxitech/ragenix";
    secrets = {
      url = "path:./secrets";
      flake = false;
    };
  };

  flake.modules.nixos.ragenix =
    { pkgs, config, ... }:
    {
      imports = [ inputs.ragenix.nixosModules.default ];

      age.secrets.sneaky.file = inputs.secrets + /sneaky.age;
      age.identityPaths = [ "/home/dragon/.ssh/id_ed25519" ];
    };
}
